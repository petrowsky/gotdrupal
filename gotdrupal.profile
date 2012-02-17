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
}

/**
 * Install operation for setting up the default taxonomy.
 */
function gotdrupal_profile_operation_taxonomy(&$context) {
  /*
  $context['message'] = t('Setting up default vocabularies.');

  require_once dirname(__FILE__) . '/taxonomy/vocabulary.inc';
  require_once dirname(__FILE__) . '/taxonomy/term.inc';

  foreach ($vocabularies as $vocabulary) {
    taxonomy_save_vocabulary($vocabulary);
  }

  foreach ($terms as $term) {
    taxonomy_save_term($term);
  }
  */
}

/**
 * Install operation for setting up demo content.
 */
function gotdrupal_profile_operation_content($file, &$context) {
}

/**
 * Last install operation.
 */
function gotdrupal_profile_operation_finished($success, $results, $operations) {
  node_access_rebuild();
  variable_set('install_task', 'profile-finished');
}
