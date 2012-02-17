<?php

// Load our own theme js to adjust admin_menu
amadou_gotdrupal_admin_menu_adjust();

/**
* Admin menu adjustments.
*
*   Add some jquery to adjust css settings when admin menu is used.
*/
function amadou_gotdrupal_admin_menu_adjust() {
  global $user, $theme_path;

  if (user_access('access administration menu')) {
    // If you want to use a file then uncomment the following line
    // drupal_add_js($theme_path . '/js/admin_menu_adjust.js', 'theme');
    $js = "$('body').css({ backgroundPosition:\"0 20px\"});";
    drupal_add_js("if (Drupal.jsEnabled) {  $(document).ready(function() { $js  }); }", 'inline');
  }
}


/**
 * Adding or modifying variables before page render.
 */
function phptemplate_preprocess_page(&$vars) {
  // Page change based on node->type
  // Figure out if the node type has a matching page
  
  if ($vars['node']->type == "video" ) {
    // print "<h1>$theme_path" .'/js/movie_player.js'. "</h1>";
    // drupal_add_js($theme_path .'/js/movie_player.js', 'theme');
    // dpm(drupal_add_js());
    // dpm($scripts);
  }
  // Note: $vars['node'] is available when the page is focused on a node. i.e., example.com/node/123
  if (isset($vars['node'])) {
    // Add template naming suggestion. It should alway use hyphens.
    $vars['template_files'][] = 'page-'. str_replace('_', '-', $vars['node']->type);    
  }
  // dfb(browscap_get_browser(), FirePHP::LOG);
}

function phptemplate_preprocess_node(&$vars) {
  // Only load the javascript for the player if it's a single node
  if ($vars['node']->type == 'video' && !$vars['is_front']) {
    // Get the base path for the video from the user profile field
    // Load the user who owns/created the video
    $video_user = user_load($vars['node']->uid);
    
    // Currently storing the base video path in a profile field
    $video_width = $vars['node']->field_video_width[0]['value'];
    $video_height = $vars['node']->field_video_height[0]['value'];
    $player_height = $video_height + 16; // Adjust for QT player controls
    $video_path_root = $video_user->profile_video_storage;
    $video_path_full = $vars['node']->field_video_path_full[0]['safe'];
    $video_path_full = (valid_url($video_path_full, TRUE)) ? $video_path_full : rtrim($video_path_root, '/') . '/' . ltrim($video_path_full, '/');
    
    //Change to the swf version for certain platforms
    // if (amadou_gotdrupal_get_browser() == 'windows' || amadou_gotdrupal_get_browser() == 'linux') {
    //   $video_path_full = str_replace('.mov', '.swf', $video_path_full);
    // }
    // Add to vars
    $vars['video']['full_path'] = $video_path_full;
    $vars['video']['preview_path'] = $vars['node']->field_video_path_preview[0]['safe'];
    $vars['video']['width'] = $video_width;
    $vars['video']['height'] = $video_height;
    
    $vars['video_link'] = '<div class="video-play">Play Video</div>' . l('Movie link (right-click to download)', $video_path_full, array('attributes' => array('class' => 'mov')));

    // $vars['video_link'] = theme('flowplayer', array(
    //     'clip' => array(
    //       'url' => $video_path_full,
    //       'autoPlay' => FALSE, // Turn autoplay off
    //     ),
    //   ));
      
    flowplayer_add('#video-player', array(
      'clip' => array(
        'autoPlay' => FALSE, // Turn autoplay off
        'url' => $video_path_full,
      ),
    ));
      
    $vars['video_player'] = "<div id=\"video-player\" style=\"width:". $video_width ."px; height: ". $video_height ."px\"></div>";
      
    // if ($vars['node']->page == TRUE) {
    // Create the javascript for the movie - using jquery_media plugin
    // $media_js = "if (Drupal.jsEnabled) {\n$(document).ready(function() {\n";
    // $media_js .= "function playMov(mov) {\n";
    // $media_js .= "$(\"a.mov\").media(mov.data);\n";
    // $media_js .= "$(\"div.mov div\").remove();\n";
    // $media_js .= "$(\"div.video-play\").remove();\n";
    // $media_js .= "}\n";
    // $media_js .= "$(\"div.video-play\").bind( \"click\", { src: \"$video_path_full\", width: $video_width, height: $player_height, autoplay: true }, playMov );";
    // $media_js .= "\n});\n}";
    
    $media_js = "if (Drupal.jsEnabled) {\n$(document).ready(function() {\n";
    $media_js .= '$(".video-play").click(function(){$("#video-player").css("display","block")});';
    $media_js .= "\n});\n}";
    
    

    // $vars['js'] = $media_js;
    // Add the js to the output
    drupal_add_js($media_js, 'inline', 'header');
    // drupal_add_js($vars['directory'] . '/js/dev.js', 'inline', 'header');
    // }
    // dpm($vars['js']);
  }
}

function amadou_gotdrupal_get_browser() {
  if (module_exists('browscap')) {
    $browser = browscap_get_browser();
    if (stristr($browser['platform'],'win')) {
      return 'windows';
    } elseif (stristr($browser['platform'],'mac')) {
      return 'macintosh';
    } elseif (stristr($browser['platform'],'linux')) {
      return 'linux';
    } elseif (stristr($browser['platform'],'iphone')) {
      return 'iphone';
    }
  }
  return 'unknown';
}
/**
* Adjust content width according to the absence or presence of sidebars.
*
*   If only one sidebar is active, the mainContent width will expand to fill
*   the space of the missing sidebar.
*/
function amadou_gotdrupal_get_mainContent_width($sidebar_left, $sidebar_right) {
  $width = 530;
  if (!$sidebar_left) {
    $width = $width + 180;
  }  
  if (!$sidebar_right) {
    $width = $width + 180;
  }  
  return $width;
}

function amadou_gotdrupal_get_sideBars_width($sidebar_left, $sidebar_right) {
  $width = 415;
  if (!$sidebar_left) {
    $width = $width - 205;
  }  
  if (!$sidebar_right) {
    $width = $width - 205;
  }  
  return $width;
}

/**
 * Return a themed breadcrumb trail.
 *
 * @param $breadcrumb
 *   An array containing the breadcrumb links.
 * @return a string containing the breadcrumb output.
 */
function phptemplate_breadcrumb($breadcrumb) {
   if (!empty($breadcrumb)) {
     return '<div class="breadcrumb">'. implode(' :: ', $breadcrumb) .'</div>';
   }
}

/**
* Customize a TinyMCE theme.
*
* @param init
*   An array of settings TinyMCE should invoke a theme. You may override any
*   of the TinyMCE settings. Details here:
*
*    http://tinymce.moxiecode.com/wrapper.php?url=tinymce/docs/using.htm
*
* @param textarea_name
*   The name of the textarea TinyMCE wants to enable.
*
* @param theme_name
*   The default tinymce theme name to be enabled for this textarea. The
*   sitewide default is 'simple', but the user may also override this.
*
* @param is_running
*   A boolean flag that identifies id TinyMCE is currently running for this
*   request life cycle. It can be ignored.
*/
function phptemplate_tinymce_theme($init, $textarea_name, $theme_name, $is_running) {

  switch ($textarea_name) {
    // Disable tinymce for these textareas
    case 'log': // book and page log
    case 'img_assist_pages':
    case 'caption': // signature
    case 'pages':
    case 'access_pages': //TinyMCE profile settings.
    case 'user_mail_welcome_body': // user config settings
    case 'user_mail_approval_body': // user config settings
    case 'user_mail_pass_body': // user config settings
    case 'synonyms': // taxonomy terms
    case 'description': // taxonomy terms
      unset($init);
      break;

    // Force the 'simple' theme for some of the smaller textareas.
    case 'signature':
    case 'site_mission':
    case 'site_footer':
    case 'site_offline_message':
    case 'page_help':
    case 'user_registration_help':
    case 'user_picture_guidelines':
      $init['theme'] = 'simple';
      foreach ($init as $k => $v) {
        if (strstr($k, 'theme_advanced_')) unset($init[$k]);
      }
      break;
  }

  // Add some extra features when using the advanced theme. 
  // If $init is available, we can extend it
  if (isset($init)) {
    switch ($theme_name) {
     case 'advanced':
   $init['width'] = '100%';
       break;
  
    }
  }

  // Always return $init
  return $init;
}
