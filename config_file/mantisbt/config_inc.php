<?php
        # --- Database Configuration ---
	$g_hostname = 'localhost';
	$g_db_type = 'mysql';
	$g_database_name = 'mantisbt';
	$g_db_username = 'root';
        $g_db_password = '524400';

        # --- Anonymous Access / Signup ---
        $g_allow_signup			= ON;
        $g_allow_anonymous_login	= OFF;
        $g_anonymous_account		= '';

        # --- Other config ---
        $g_use_iis = ON;     # Use IIS
        $g_show_version = ON;     #view Mantis version
        $g_default_language = 'chinese_simplified_utf8';
        $g_default_language = 'chinese_simplified'; # defaule language is chanese 
        $g_show_project_menu_bar = ON; 
        $g_show_queries_count = OFF; 
        $g_default_new_account_access_level = DEVELOPER; # default user level

        # --- Set title Configuration ---
        $g_window_title = 'Smart Systems Mantis Bug Tracker'; # IE Title 
        $g_page_title = 'Smart Systems Mantis Bug Tracker'; # Page Title

        # --- Set date Configuration ---
        $g_short_date_format = 'Y-m-d';
        $g_normal_date_format = 'Y-m-d H:i';
        $g_complete_date_format = 'Y-m-d H:i:s';

        # --- Set jpgraph Configuration ---
        $g_use_jpgraph=ON; #Enable JPGraph
        $g_jpgraph_path = '/opt/lampp/htdocs/mantisbt/core/jpgraph-3.5.0b1/src/';
        $g_jpgraph_path = './core/jpgraph-3.5.0b1/src/'; #JPGraph cmd path

        # --- Email Configuration ---
        $g_phpMailer_method	= PHPMAILER_METHOD_MAIL; # or PHPMAILER_METHOD_SMTP, PHPMAILER_METHOD_SENDMAIL
        $g_smtp_host		= 'localhost'; 		# used with PHPMAILER_METHOD_SMTP
        $g_smtp_username	= '';			# used with PHPMAILER_METHOD_SMTP
        $g_smtp_password	= '';			# used with PHPMAILER_METHOD_SMTP
        $g_administrator_email  = 'MantisBT@126.com';
        $g_webmaster_email      = 'MantisBT@126.com';
        $g_from_name		= 'Mantis Bug Tracker';
        $g_from_email           = 'MantisBT@126.com';# the "From: " field in emails
        $g_return_path_email    = 'MantisBT@126.com';	# the return address for bounced mail
        $g_email_receive_own	= OFF;
        $g_email_send_using_cronjob = OFF;
        $g_enable_email_notification = ON; # Enable email notification for buger 

        $g_smtp_host		= 'smtp.126.com';
        $g_smtp_port            = 25;
        $g_smtp_connection_mode = ''; # 'ssl' or 'tls'
        $g_smtp_username        = 'MantisBT';
        $g_smtp_password        = '524400';
        $g_phpMailer_method	= 2;
        $g_use_phpMailer        = ON;
        $g_phpMailer_path       = '/opt/lampp/htdocs/mantisbt/core/PHPMailer_v5.1/';
        $g_phpMailer_path       = './core/PHPMailer_v5.1/';
        

        # --- Attachments / File Uploads ---
        $g_allow_file_upload	= ON;
        $g_file_upload_method	= DATABASE; # or DISK
        $g_file_upload_method   = DISK; #save server disk space
        $g_max_file_size        = 5000000; #Mantis enable file size is 5000000 and <= php.ini
        $g_absolute_path_default_upload_folder = ''; # used with DISK, must contain trailing \ or /.
        $g_absolute_path_default_upload_folder = '/opt/lampp/htdocs/mantisbt/upload/';
        $g_absolute_path_default_upload_folder = './core/upload/';
        $g_preview_attachments_inline_max_size = 256 * 1024;
        $g_allowed_files	= '';	# extensions comma separated, e.g. 'php,html,java,exe,pl'
        $g_disallowed_files	= '';	# extensions comma separated
        
        # --- Branding ---
        $g_window_title		= 'MantisBT';
        $g_logo_image		= 'images/mantis_logo.gif';
        $g_favicon_image	= 'images/favicon.ico';
        
        # --- Real names ---
        $g_show_realname = OFF;
        $g_show_realname = ON;
        $g_show_user_realname_threshold = NOBODY;	# Set to access level (e.g. VIEWER, REPORTER, DEVELOPER, MANAGER, etc)
        
        # --- Others ---
        $g_default_home_page = 'my_view_page.php';	# Set to name of page to go to after login
?>
