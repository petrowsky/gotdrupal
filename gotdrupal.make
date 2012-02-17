; $Id$

; This make file contains instructions, possible patches and third party
; libraries which will be loaded into your site platform hosted on Omega8.cc.

; Core

core = "6.x"

; Contrib
; ------------------
;projects[jquery_ui][subdir] = "contrib"
projects[admin_menu][subdir] = "contrib"
projects[adsense][subdir] = "contrib"
projects[advanced_help][subdir] = "contrib"
projects[backup_migrate][subdir] = "contrib"
projects[better_formats][subdir] = "contrib"
projects[browscap][subdir] = "contrib"
projects[cck][subdir] = "contrib"
projects[codefilter][subdir] = "contrib"
projects[comment_notify][subdir] = "contrib"
projects[content_access][subdir] = "contrib"
projects[ctools][subdir] = "contrib"
projects[date][subdir] = "contrib"
projects[emfield][subdir] = "contrib"
projects[fasttoggle][subdir] = "contrib"
projects[filefield][subdir] = "contrib"
projects[filter_perms][subdir] = "contrib"
projects[flowplayer][subdir] = "contrib"
projects[globalredirect][subdir] = "contrib"
projects[googleanalytics][subdir] = "contrib"
projects[google_cse][subdir] = "contrib"
projects[imagefield][subdir] = "contrib"
projects[jquery_update][subdir] = "contrib"
projects[libraries][subdir] = "contrib"
projects[logintoboggan][subdir] = "contrib"
projects[markdown][subdir] = "contrib"
projects[mimemail][subdir] = "contrib"
projects[module_filter][subdir] = "contrib"
projects[mollom][subdir] = "contrib"
projects[nodewords][subdir] = "contrib"
projects[pathauto][subdir] = "contrib"
projects[path_redirect][subdir] = "contrib"
projects[phpmailer][subdir] = "contrib"
projects[robotstxt][subdir] = "contrib"
projects[rules][subdir] = "contrib"
projects[semanticviews][subdir] = "contrib"
projects[shorten][subdir] = "contrib"
projects[shorturl][subdir] = "contrib"
projects[token][subdir] = "contrib"
projects[tweet][subdir] = "contrib"
projects[typogrify][subdir] = "contrib"
projects[uncaptchalous][subdir] = "contrib"
projects[vertical_tabs][subdir] = "contrib"
projects[views][subdir] = "contrib"
projects[views_bulk_operations][subdir] = "contrib"
projects[webform][subdir] = "contrib"
projects[xmlsitemap][subdir] = "contrib"

; Custom
; ----------------------
;rss_enclosure
projects[rss_enclosure][subdir] = "custom"
projects[rss_enclosure][download][type] = "file"
projects[rss_enclosure][download][url] = "file:///data/disk/o1/static/rss_enclosure.zip"

; Patches
; ------------------
; http://drupal.org/node/885412
; projects[disqus][patch][] = "http://drupal.org/files/issues/disqus-views-relationships.patch"

; http://drupal.org/node/624018
; projects[wysiwyg][patch][] = "http://drupal.org/files/issues/wysiwyg-624018-with-ui-3.patch"

; Libraries
; ------------------
;libraries[jquery_ui][download][type] = "get"
;libraries[jquery_ui][download][url] = "http://jquery-ui.googlecode.com/files/jquery-ui-1.7.3.zip"
;libraries[jquery_ui][destination] = "modules/contrib/jquery_ui"
;libraries[jquery_ui][directory_name] = "jquery.ui"

; Themes
; ------------------
projects[tao][type] = theme
projects[tao][subdir] = themes

; Rubik is included by Omega boxes
;projects[rubik][type] = theme
;projects[rubik][subdir] = themes

;@todo move this to it's own repo? Going to change the theme
projects[amadou_gotdrupal][type] = theme
projects[amadou_gotdrupal][subdir] = themes
projects[amadou_gotdrupal][download][type] = "file"
projects[amadou_gotdrupal][download][url] = "file:///data/disk/o1/static/amadou_gotdrupal.zip"

; Omega default modules
; ----------------------
; The following modules are included on your Omega box
; by default. DO NOT UNCOMMENT THESE! They are here
; so you know which modules you DO NOT NEED to include in
; your own custom make file.
;
; More information at these links
; http://omega8.cc/extra-modules-available-in-all-platforms-123
; http://omega8.cc/modules-enabled-or-disabled-automatically-117#comment-574
; http://drupalcode.org/project/barracuda.git/blob/HEAD:/README.txt
;
;projects[backup_migrate][subdir] = "contrib"
;projects[backup_migrate][version] = "6.x-2.4"
;
;projects[blockcache_alter][subdir] = "contrib"
;projects[blockcache_alter][version] = "6.x-1.x-dev"
;
;projects[boost][subdir] = "contrib"
;projects[boost][version] = "6.x-1.x-dev"
;
;projects[cache][subdir] = "contrib"
;projects[cache][version] = "6.x-1.x-dev"
;
;projects[config_perms][subdir] = "contrib"
;projects[config_perms][version] = "6.x-2.x-dev"
;
;projects[css_emimage][subdir] = "contrib"
;projects[css_emimage][version] = "6.x-2.x-dev"
;
;projects[dbtuner][subdir] = "contrib"
;projects[dbtuner][version] = "6.x-1.x-dev"
;
;projects[expire][subdir] = "contrib"
;projects[expire][version] = "6.x-1.x"
;
;projects[filefield_nginx_progress][subdir] = "contrib"
;projects[filefield_nginx_progress][version] = "6.x-1.x-dev"
;
;projects[fpa][subdir] = "contrib"
;projects[fpa][version] = "6.x-2.3"
;
;projects[httprl][subdir] = "contrib"
;projects[httprl][version] = "6.x-1.4"
;
;projects[image][subdir] = "contrib"
;projects[image][version] = "6.x-1.x-dev"
;
;projects[login_security][subdir] = "contrib"
;projects[login_security][version] = "6.x-1.x-dev"
;
;projects[private_upload][subdir] = "contrib"
;projects[private_upload][version] = "6.x-1.x-dev"
;
;projects[purge][subdir] = "contrib"
;projects[purge][version] = "6.x-1.x"
;
;projects[readonlymode][subdir] = "contrib"
;projects[readonlymode][version] = "6.x-1.x-dev"
;
;projects[robotstxt][subdir] = "contrib"
;projects[robotstxt][version] = "6.x-1.x-dev"
;
;projects[seckit][subdir] = "contrib"
;projects[seckit][version] = "6.x-1.3"
;
;projects[securesite][subdir] = "contrib"
;projects[securesite][version] = "6.x-2.4"
;
;projects[site_verify][subdir] = "contrib"
;projects[site_verify][version] = "6.x-1.0"
;
;projects[taxonomy_edge][subdir] = "contrib"
;projects[taxonomy_edge][version] = "6.x-1.3"
;
;projects[textile][subdir] = "contrib"
;projects[textile][version] = "6.x-2.4"
;
;projects[variable_clean][subdir] = "contrib"
;projects[variable_clean][version] = "6.x-1.x-dev"
;
;projects[views_content_cache][subdir] = "contrib"
;projects[views_content_cache][version] = "6.x-2.x-dev"
;
;projects[views404][subdir] = "contrib"
;projects[views404][version] = "6.x-1.x-dev"
