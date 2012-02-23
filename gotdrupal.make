; This make file contains instructions, possible patches and third party
; libraries which will be loaded into your site platform hosted on Omega8.cc.

; Core

api = 2
core = 6.x

; Contrib
; ------------------
projects[admin_menu][download][type] = git
projects[admin_menu][download][url] = http://git.drupal.org/project/admin_menu.git
projects[admin_menu][download][branch] = 6.x-3.x

projects[adsense][version] = 1.3
projects[advagg][version] = 1.6
projects[advanced_help][version] = 1.2
projects[better_formats][version] = 1.2
projects[browscap][version] = 1.3
projects[cck][version] = 2.9
projects[codefilter][version] = 1.0
projects[comment_notify][version] = 1.6
projects[content_access][version] = 1.2
projects[ctools][version] = 1.8
projects[date][version] = 2.8
projects[emfield][version] = 2.5
projects[fasttoggle][version] = 1.4
projects[filefield][version] = 3.10
projects[filter_perms][version] = 1.1
projects[flowplayer][version] = 1.0-beta1 
projects[globalredirect][version] = 1.4
projects[google_analytics][version] = 3.3
projects[google_cse][version] = 1.2
projects[imagefield][version] = 3.10
projects[jquery_ui][version] = 1.5
projects[jquery_update][version] = 2.0-alpha1
projects[libraries][version] = 1.0
projects[logintoboggan][version] = 1.10
projects[markdown][version] = 1.2
projects[mimemail][version] = 1.0
projects[module_filter][version] = 1.7
projects[mollom][version] = 1.16
projects[nodewords][version] = 1.13
projects[pathauto][version] = 1.6
projects[path_redirect][version] = 1.0-rc2
projects[rules][version] = 1.4
projects[semanticviews][version] = 1.1
projects[shorten][version] = 1.12
projects[shorturl][version] = 1.3
projects[strongarm][version] = 2.1
projects[token][version] = 1.18
projects[tweet][version] = 4.3
projects[typogrify][version] = 1.0
projects[uncaptchalous][version] = 1.0-beta4
projects[vertical_tabs][version] = 1.0-rc2
projects[views][version] = 2.16
projects[views_bulk_operations][version] = 1.13
projects[webform][version] = 3.15
projects[xmlsitemap][version] = 2.0-rc1

; Custom
; ----------------------
;rss_enclosure
;projects[rss_enclosure][subdir] = "custom"
;projects[rss_enclosure][download][type] = "file"
;projects[rss_enclosure][download][url] = "file:///data/disk/o1/static/rss_enclosure.zip"

; Libraries
; ------------------
libraries[jquery_ui][download][type] = get
libraries[jquery_ui][download][url] = http://jquery-ui.googlecode.com/files/jquery-ui-1.7.3.zip
libraries[jquery_ui][destination] = libraries
libraries[jquery_ui][directory_name] = jquery.ui

libraries[profiler][download][type] = get
libraries[profiler][download][url] = http://ftp.drupal.org/files/projects/profiler-6.x-2.0-beta2.tar.gz
libraries[profiler][destination] = libraries

; http://drupal.org/node/906106
libraries[profiler][patch][] = http://drupal.org/files/issues/profiler.906106-11.patch

; http://drupal.org/node/1013430
libraries[profiler][patch][] = http://drupal.org/files/issues/profiler-install-files.patch

; Themes
; ------------------
projects[tao][type] = theme
projects[tao][version] = 3.2

; Rubik is included by Omega boxes
;projects[rubik][type] = theme
;projects[rubik][subdir] = themes

;@todo move this to it's own repo? Going to change the theme
;projects[amadou_gotdrupal][type] = theme
;projects[amadou_gotdrupal][subdir] = themes
;projects[amadou_gotdrupal][download][type] = "file"
;projects[amadou_gotdrupal][download][url] = "file:///data/disk/o1/static/amadou_gotdrupal.zip"

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
; projects[backup_migrate][subdir] = "contrib"
; projects[backup_migrate][version] = "6.x-2.4"
; 
; projects[blockcache_alter][subdir] = "contrib"
; projects[blockcache_alter][version] = "6.x-1.x-dev"
; 
; projects[boost][subdir] = "contrib"
; projects[boost][version] = "6.x-1.x-dev"
; 
; projects[cache][subdir] = "contrib"
; projects[cache][version] = "6.x-1.x-dev"
; 
; projects[config_perms][subdir] = "contrib"
; projects[config_perms][version] = "6.x-2.x-dev"
; 
; projects[css_emimage][subdir] = "contrib"
; projects[css_emimage][version] = "6.x-2.x-dev"
; 
; projects[dbtuner][subdir] = "contrib"
; projects[dbtuner][version] = "6.x-1.x-dev"
; 
; projects[expire][subdir] = "contrib"
; projects[expire][version] = "6.x-1.x"
; 
; projects[filefield_nginx_progress][subdir] = "contrib"
; projects[filefield_nginx_progress][version] = "6.x-1.x-dev"
; 
; projects[fpa][subdir] = "contrib"
; projects[fpa][version] = "6.x-2.3"
; 
; projects[httprl][subdir] = "contrib"
; projects[httprl][version] = "6.x-1.4"
; 
; projects[image][subdir] = "contrib"
; projects[image][version] = "6.x-1.x-dev"
; 
; projects[login_security][subdir] = "contrib"
; projects[login_security][version] = "6.x-1.x-dev"
; 
; projects[private_upload][subdir] = "contrib"
; projects[private_upload][version] = "6.x-1.x-dev"
; 
; projects[purge][subdir] = "contrib"
; projects[purge][version] = "6.x-1.x"
; 
; projects[readonlymode][subdir] = "contrib"
; projects[readonlymode][version] = "6.x-1.x-dev"
; 
; projects[robotstxt][subdir] = "contrib"
; projects[robotstxt][version] = "6.x-1.x-dev"
; 
; projects[seckit][subdir] = "contrib"
; projects[seckit][version] = "6.x-1.3"
; 
; projects[securesite][subdir] = "contrib"
; projects[securesite][version] = "6.x-2.4"
; 
; projects[site_verify][subdir] = "contrib"
; projects[site_verify][version] = "6.x-1.0"
; 
; projects[taxonomy_edge][subdir] = "contrib"
; projects[taxonomy_edge][version] = "6.x-1.3"
; 
; projects[textile][subdir] = "contrib"
; projects[textile][version] = "6.x-2.4"
; 
; projects[variable_clean][subdir] = "contrib"
; projects[variable_clean][version] = "6.x-1.x-dev"
; 
; projects[views_content_cache][subdir] = "contrib"
; projects[views_content_cache][version] = "6.x-2.x-dev"
; 
; projects[views404][subdir] = "contrib"
; projects[views404][version] = "6.x-1.x-dev"
