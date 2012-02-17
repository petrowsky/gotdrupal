<?php

/**
 * @file
 * This is the installation profile for GotDrupal.
 */

/**
 * Implementation of hook_profile_details().
 */
function gotdrupal_profile_details() {
  return array(
    'name' => 'GotDrupal',
    'description' => 'Cool, GotDrupal has it\'s own profile - even though only one site uses it.',
  );
}

/**
 * Implementation of hook_profile_modules().
 *
 * Note that modules defined here are not hard dependencies. Additional modules
 * will be required as dependencies to other modules here.
 */
function gotdrupal_profile_modules() {
  return array(
    // Core.
    'help',
    'menu',
    'path',
    'taxonomy',

    // Contrib.
    'admin_menu',
    'adsense',
    'adsense_click',
    'adsense_managed',
    'advanced_help',
    'amadou_gotdrupal',
    'better_formats',
    'block',
    'blog',
    'blogapi',
    'boost',
    'browscap',
    'cache',
    'codefilter',
    'comment',
    'comment_notify',
    'content',
    'content_access',
    'content_permissions',
    'date',
    'date_api',
    'date_popup',
    'date_timezone',
    'dbtuner',
    'emfield',
    'expire',
    'faceted_search',
    'faceted_search_ui',
    'fieldgroup',
    'filefield',
    'filefield_nginx_progress',
    'filter',
    'flowplayer',
    'globalredirect',
    'googleanalytics',
    'google_cse',
    'image',
    'imagefield',
    'jquery_ui',
    'jquery_update',
    'libraries',
    'markdown',
    'mollom',
    'node',
    'nodereference',
    'nodewords',
    'nodewords_basic',
    'nodewords_extra',
    'number',
    'openid',
    'optionwidgets',
    'pathauto',
    'path_alias_cache',
    'path_redirect',
    'phpmailer',
    'pmail',
    'pngfix',
    'profile',
    'purge',
    'record_shorten',
    'rss_enclosure',
    'search',
    'shorten',
    'shorturl',
    'site_verify',
    'system',
    'taxonomy_facets',
    'text',
    'token',
    'tweet',
    'typogrify',
    'upload',
    'user',
    'views',
    'views_ui',
    'webform',

    // GotDrupal.
    'rss_enclosure',
  );
}

/**
 * Implementation of hook_profile_task_list().
 */
function gotdrupal_profile_task_list() {
}

/**
 * Helper function for fetching the order of demo content files.
 */
function gotdrupal_profile_content_files() {
}

/**
 * Implementation of hook_profile_tasks().
 */
function gotdrupal_profile_tasks(&$task, $url) {
  if ($task == 'profile') {
    $batch = array();
    $batch['title'] = st('Configuring @drupal', array('@drupal' => drupal_install_profile_name()));
    $batch['error_message'] = st('There was an error configuring @drupal.', array('@drupal' => drupal_install_profile_name()));

    $batch['operations'][] = array('gotdrupal_profile_operation_prepare', array());
    $batch['operations'][] = array('gotdrupal_profile_operation_basic', array());
    $batch['operations'][] = array('gotdrupal_profile_operation_social', array());
    $batch['operations'][] = array('gotdrupal_profile_operation_taxonomy', array());
    foreach (gotdrupal_profile_content_files() as $file) {
      $batch['operations'][] = array('gotdrupal_profile_operation_content', array($file));
    }
    $batch['finished'] = 'gotdrupal_profile_operation_finished';

    variable_set('install_task', 'ns-batch');
    batch_set($batch);
    batch_process($url, $url);
    // Jut for cli installs.
    return;
  }

  // We are running a batch task for this profile so do nothing and return page.
  if ($task == 'ns-batch') {
    include_once 'includes/batch.inc';
    $output = _batch_page();
  }

  return $output;
}

/**
 * Preparing install operation.
 */
function gotdrupal_profile_operation_prepare(&$context) {
  $context['message'] = t('Preparing configuration.');
  drupal_flush_all_caches();
}

/**
 * Install operation for basic stuff.
 */
function gotdrupal_profile_operation_basic(&$context) {
  $context['message'] = t('Setting up basic features.');

  // Define Pathauto settings before saving vocabularies and terms.
  variable_set('pathauto_node_pattern', '');
  variable_set('pathauto_taxonomy_pattern', '');
  variable_set('pathauto_user_pattern', '');

  // Site front page.
  variable_set('site_frontpage', 'taxonomy/term/1');

  // Setup Geo Taxonomy to work with our recently created vocabulary.
  variable_set('geotaxonomy_3', TRUE);

  // We create the ad group vocabulary so we can ad some default groups.
  variable_set('ad_group_vid', 4);
  // Use the raw display format.
  variable_set('ad_display', 'raw');

  // Define some basic menu links.
  $menu_links = array(
    array(
      'link_title' => 'Front page',
      'link_path' => '<front>',
      'menu_name' => 'primary-links',
      'weight' => -10,
      'hidden' => FALSE,
    ),
    array(
      'link_title' => 'Business',
      'link_path' => 'taxonomy/term/2',
      'menu_name' => 'primary-links',
      'weight' => -9,
      'hidden' => FALSE,
    ),
    array(
      'link_title' => 'Technology',
      'link_path' => 'taxonomy/term/3',
      'menu_name' => 'primary-links',
      'weight' => -8,
      'hidden' => FALSE,
    ),
  );

  // Save menu links.
  foreach ($menu_links as $menu_link) {
    menu_link_save($menu_link);
  }

  // Remove all blocks.
  db_query("TRUNCATE {blocks}");

  // Only admin users can create new user accounts on the site.
  variable_set('user_register', 0);

  // Date configuration.
  variable_set('configurable_timezones', 0);
  variable_set('date_first_day', 1);
  variable_set('date_format_short', 'Y-m-d H:i');
  variable_set('date_format_short_custom', 'Y-m-d H:i');
  variable_set('date_format_medium', 'D, Y-m-d H:i');
  variable_set('date_format_medium_custom', 'D, Y-m-d H:i');
  variable_set('date_format_long', 'l, j F, Y - H:i');
  variable_set('date_format_long_custom', 'l, j F, Y - H:i');

  // Scheduler date format.
  variable_set('scheduler_date_format', 'Y-m-d H:i');

  // Theme related stuff.
  variable_set('theme_default', 'ns_default');
  variable_set('admin_theme', 'ns_seven');
  variable_set('node_admin_theme', 1);

  // Setup the Admin toolbar.
  variable_set(
    'admin_toolbar',
    array(
      'layout' => 'vertical',
      'position' => 'nw',
      'blocks' => array(
        'admin-create' => -1,
        'admin-menu' => 1,
        'admin-devel' => -1,
        'ns_core-ns_core_region_editor' => -1,
        'ns_core-ns_core_local_tasks' => -1,
      ),
    )
  );

  // Setup conditional fields.
  conditional_fields_insert_field('ns_image', 'field_ns_image_url', 'field_ns_image_type', array('embed' => 'embed'));
  conditional_fields_insert_field('ns_image', 'field_ns_image_file', 'field_ns_image_type', array('local' => 'local'));

  // Setup node telationships and widgets.
  module_load_include('inc', 'noderelationships', 'noderelationships');
  noderelationships_settings_save(
    'ns_article',
    array(
      'noderef' => array(
        'search_and_reference_view' => array(
          'field_ns_article_attachment' => 'noderelationships_noderef:page_grid',
          'field_ns_article_byline' => 'noderelationships_noderef:page_grid',
          'field_ns_article_image' => 'noderelationships_noderef:page_grid',
        ),
        'create_and_reference' => array(
          'field_ns_article_attachment' => 'field_ns_article_attachment',
          'field_ns_article_byline' => 'field_ns_article_byline',
          'field_ns_article_image' => 'field_ns_article_image',
        ),
        'edit_reference' => array(
          'field_ns_article_attachment' => 'field_ns_article_attachment',
          'field_ns_article_byline' => 'field_ns_article_byline',
          'field_ns_article_image' => 'field_ns_article_image',
        ),
      ),
    )
  );
  noderelationships_settings_save(
    'ns_blog',
    array(
      'noderef' => array(
        'search_and_reference_view' => array(
          'field_ns_blog_blogger' => 'noderelationships_noderef:page_grid',
        ),
        'create_and_reference' => array(
          'field_ns_blog_blogger' => 'field_ns_blog_blogger',
        ),
        'edit_reference' => array(
          'field_ns_blog_blogger' => 'field_ns_blog_blogger',
        ),
      ),
    )
  );
  noderelationships_settings_save(
    'ns_image',
    array(
      'noderef' => array(
        'search_and_reference_view' => array(
          'field_ns_image_credit' => 'noderelationships_noderef:page_grid',
        ),
        'create_and_reference' => array(
          'field_ns_image_credit' => 'field_ns_image_credit',
        ),
        'edit_reference' => array(
          'field_ns_image_credit' => 'field_ns_image_credit',
        ),
      ),
    )
  );
  noderelationships_settings_save(
    'ns_post',
    array(
      'noderef' => array(
        'search_and_reference_view' => array(
          'field_ns_post_blog' => 'noderelationships_noderef:page_grid',
          'field_ns_post_blogger' => 'noderelationships_noderef:page_grid',
        ),
        'create_and_reference' => array(
          'field_ns_post_blog' => 'field_ns_post_blog',
          'field_ns_post_blogger' => 'field_ns_post_blogger',
        ),
        'edit_reference' => array(
          'field_ns_post_blog' => 'field_ns_post_blog',
          'field_ns_post_blogger' => 'field_ns_post_blogger',
        ),
      ),
    )
  );
  noderelationships_settings_save(
    'ns_promo',
    array(
      'noderef' => array(
        'search_and_reference_view' => array(
          'field_ns_promo_article' => 'noderelationships_noderef:page_grid',
          'field_ns_promo_image' => 'noderelationships_noderef:page_grid',
          'field_ns_promo_parent' => 'noderelationships_noderef:page_grid',
        ),
        'create_and_reference' => array(
          'field_ns_promo_article' => 'field_ns_promo_article',
          'field_ns_promo_image' => 'field_ns_promo_image',
          'field_ns_promo_parent' => 'field_ns_promo_parent',
        ),
        'edit_reference' => array(
          'field_ns_promo_article' => 'field_ns_promo_article',
          'field_ns_promo_image' => 'field_ns_promo_image',
          'field_ns_promo_parent' => 'field_ns_promo_parent',
        ),
      ),
    )
  );
  noderelationships_settings_save(
    'ns_video',
    array(
      'noderef' => array(
        'search_and_reference_view' => array(
          'field_ns_video_credit' => 'noderelationships_noderef:page_grid',
        ),
        'create_and_reference' => array(
          'field_ns_video_credit' => 'field_ns_video_credit',
        ),
        'edit_reference' => array(
          'field_ns_video_credit' => 'field_ns_video_credit',
        ),
      ),
    )
  );

  // Delete the default webform content type.
  node_type_delete('webform');

  variable_set('emfield_emimage_allow_flickr', 1);
  variable_set('emfield_emimage_allow_photobucket', 1);
  variable_set('emfield_emimage_allow_picasa', 1);

  // Enable some page panels.
  variable_set('page_manager_term_view_disabled', 0);
  variable_set('page_manager_node_view_disabled', 0);
  variable_set('panels_everywhere_site_template_enabled', 1);
}

/**
 * Install operation for setting up social features.
 */
function gotdrupal_profile_operation_social(&$context) {
  $context['message'] = t('Setting up social features.');

  variable_set('twitter_default_format', '!title !tinyurl');
  variable_set(
    'twitter_types',
    array(
      'ns_article' => 'ns_article',
      'ns_blog' => 0,
      'ns_contributor' => 0,
      'ns_fact' => 0,
      'ns_form' => 0,
      'ns_image' => 0,
      'ns_location' => 0,
      'ns_page' => 0,
      'ns_post' => 'ns_post',
      'ns_promo' => 0,
      'ns_video' => 0,
      'poll' => 0,
    )
  );

  variable_set('disqus_location', 'block');
  variable_set(
    'disqus_nodetypes',
    array(
      'ns_article' => 'ns_article',
      'ns_blog' => 0,
      'ns_contributor' => 0,
      'ns_fact' => 0,
      'ns_form' => 0,
      'ns_image' => 0,
      'ns_location' => 0,
      'ns_page' => 0,
      'ns_post' => 'ns_post',
      'ns_promo' => 0,
      'ns_video' => 0,
      'poll' => 0,
    )
  );
}

/**
 * Install operation for setting up the default taxonomy.
 */
function gotdrupal_profile_operation_taxonomy(&$context) {
  $context['message'] = t('Setting up default vocabularies.');

  require_once dirname(__FILE__) . '/taxonomy/vocabulary.inc';
  require_once dirname(__FILE__) . '/taxonomy/term.inc';

  foreach ($vocabularies as $vocabulary) {
    taxonomy_save_vocabulary($vocabulary);
  }

  foreach ($terms as $term) {
    taxonomy_save_term($term);
  }
}

/**
 * Install operation for setting up demo content.
 */
function gotdrupal_profile_operation_content($file, &$context) {
  $context['message'] = t('Setting up demo content.');
  $user = user_load(array('uid' => 1));

  require_once dirname(__FILE__) . '/content/' . $file . '.inc';

  foreach ($nodes as $node) {
    $node = (object)$node;
    node_save($node);
  }
}

/**
 * Last install operation.
 */
function gotdrupal_profile_operation_finished($success, $results, $operations) {
  node_access_rebuild();
  variable_set('install_task', 'profile-finished');
}
