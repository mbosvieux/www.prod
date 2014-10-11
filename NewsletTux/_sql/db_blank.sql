-- TABLE : Config
DROP TABLE IF EXISTS {NTUX3_DB_PREFIX}config;
DROP TABLE IF EXISTS {NTUX3_DB_PREFIX}log_actions;
DROP TABLE IF EXISTS {NTUX3_DB_PREFIX}log_errors;
DROP TABLE IF EXISTS {NTUX3_DB_PREFIX}newsletters;
DROP TABLE IF EXISTS {NTUX3_DB_PREFIX}newsletters_attachments;
DROP TABLE IF EXISTS {NTUX3_DB_PREFIX}newsletters_emails;
DROP TABLE IF EXISTS {NTUX3_DB_PREFIX}newsletters_sent_to;
DROP TABLE IF EXISTS {NTUX3_DB_PREFIX}newsletters_templates;
DROP TABLE IF EXISTS {NTUX3_DB_PREFIX}profiles;
DROP TABLE IF EXISTS {NTUX3_DB_PREFIX}profiles_regs;
DROP TABLE IF EXISTS {NTUX3_DB_PREFIX}profiles_unregs;
DROP TABLE IF EXISTS {NTUX3_DB_PREFIX}profiles_perms;
DROP TABLE IF EXISTS {NTUX3_DB_PREFIX}usergroups_perms;
DROP TABLE IF EXISTS {NTUX3_DB_PREFIX}users;




-- ---------------------------------------------------------------------------
-- TABLE : main config
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}config (
	var VARCHAR(255) NOT NULL,
	val TEXT         NOT NULL,

	PRIMARY KEY(var)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;



-- ---------------------------------------------------------------------------
-- TABLE : log all actions
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}log_actions (
	id            INT(10)      NOT NULL auto_increment,
	id_user       INT(10)      NOT NULL,

	ip            VARCHAR(255) NOT NULL,
	ua            VARCHAR(255) NOT NULL,
	act_datetime  DATETIME     NOT NULL DEFAULT '2000-01-01 00:00:00',
	act_origin    VARCHAR(255) NOT NULL,
	act_type      VARCHAR(255) NOT NULL,
	act_msg       TEXT         NOT NULL,

	PRIMARY KEY(id)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;



-- ---------------------------------------------------------------------------
-- TABLE : log all errors
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}log_errors (
	id            INT(10)      NOT NULL auto_increment,
	id_user       INT(10)      NOT NULL,

	ip            VARCHAR(255) NOT NULL,
	ua            VARCHAR(255) NOT NULL,
	err_datetime  DATETIME     NOT NULL DEFAULT '2000-01-01 00:00:00',
	err_origin    VARCHAR(255) NOT NULL,
	err_type      VARCHAR(255) NOT NULL,
	err_msg       TEXT         NOT NULL,

	PRIMARY KEY(id)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;



-- ---------------------------------------------------------------------------
-- TABLE : newsletters (drafts + sent)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}newsletters (
	id                INT(10)        NOT NULL auto_increment,
	id_sender         INT(10)        NOT NULL DEFAULT 0,
	id_template       INT(10)        NOT NULL DEFAULT 0,

	sender_name       VARCHAR(255)   NOT NULL DEFAULT '',
	sender_email      VARCHAR(255)   NOT NULL DEFAULT '',
	sender_groupval   ENUM('root','admin','writer') NOT NULL DEFAULT 'root',

	subject           VARCHAR(255)   NOT NULL DEFAULT '',
	content           LONGTEXT       NOT NULL,
	final_text        LONGTEXT       NOT NULL,
	final_html        LONGTEXT       NOT NULL,
	user_footer       TEXT           NOT NULL,

	is_draft          ENUM('0','1')  NOT NULL DEFAULT '1',
	is_scheduled      ENUM('0','1')  NOT NULL DEFAULT '0',
	created           DATETIME       NOT NULL DEFAULT '2000-01-01 00:00:00',
	date_send_start   DATETIME       NOT NULL DEFAULT '2000-01-01 00:00:00',
	date_send_end     DATETIME       NOT NULL DEFAULT '2000-01-01 00:00:00',
	unit_test_date    DATETIME       NOT NULL DEFAULT '2000-01-01 00:00:00',
	unit_test_email   VARCHAR(255)   NOT NULL,
	sending_status    ENUM('not_ready', 'ut_sent', 'ut_check', 'ready', 'doing', 'paused', 'done') NOT NULL DEFAULT 'not_ready',

	num_contacts      INT(5)         NOT NULL DEFAULT 0,
	num_sent_text     INT(10)        NOT NULL DEFAULT 0,
	num_sent_html     INT(10)        NOT NULL DEFAULT 0,
	num_web_reads     INT(10)        NOT NULL DEFAULT 0,
	-- num_mail_reads    INT(10)        NOT NULL DEFAULT 0,

	PRIMARY KEY(id)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;



-- ---------------------------------------------------------------------------
-- TABLE : newsletters attachments
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}newsletters_attachments (
	id                 INT(10)        NOT NULL auto_increment,
	id_newsletter      INT(10)        NOT NULL,

	filename           VARCHAR(255)   NOT NULL,
	filesize           INT(11)        NOT NULL DEFAULT 0,
	file_ts            VARCHAR(19)    NOT NULL,
	is_deletable       ENUM('0', '1') NOT NULL DEFAULT '0',

	PRIMARY KEY(id),
	UNIQUE(id_newsletter, filename, file_ts)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;



-- ---------------------------------------------------------------------------
-- TABLE : newsletters emails (for sending)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}newsletters_emails (
	id                 BIGINT(20)     NOT NULL auto_increment,
	id_newsletter      INT(10)        NOT NULL,

	target_id_user     INT(10)        NOT NULL DEFAULT 0,
	target_email       VARCHAR(50)    NOT NULL,
	format             ENUM('TEXT','HTML') NOT NULL DEFAULT 'HTML',
	done               ENUM('0', '1') NOT NULL DEFAULT '0',

	PRIMARY KEY(id),
	UNIQUE(id_newsletter, target_email)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;



-- ---------------------------------------------------------------------------
-- TABLE : newsletters images
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}newsletters_images (
	id                 INT(10)        NOT NULL auto_increment,
	id_user            INT(10)        NOT NULL,

	filename           VARCHAR(255)   NOT NULL,
	filesize           INT(11)        NOT NULL DEFAULT 0,
	file_ts            VARCHAR(19)    NOT NULL,

	PRIMARY KEY(id)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;



-- ---------------------------------------------------------------------------
-- TABLE : newsletters sent to profiles
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}newsletters_sent_to (
	id_newsletter  INT(10) NOT NULL,
	id_profile     INT(10) NOT NULL,

	PRIMARY KEY(id_newsletter, id_profile)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;



-- ---------------------------------------------------------------------------
-- TABLE : newsletters templates
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}newsletters_templates (
	id                 INT(10)        NOT NULL auto_increment,

	name               VARCHAR(255)   NOT NULL,
	filesize           INT(10)        NOT NULL DEFAULT 0,
	mark_newslettux    ENUM('0', '1') NOT NULL DEFAULT '0',
	mark_footer        ENUM('0', '1') NOT NULL DEFAULT '0',
	mark_read_site     ENUM('0', '1') NOT NULL DEFAULT '0',
	mark_unreg_link    ENUM('0', '1') NOT NULL DEFAULT '0',
	mark_newslettux_ad ENUM('0', '1') NOT NULL DEFAULT '0',
	is_dynamic         ENUM('0', '1') NOT NULL DEFAULT '0',
	unreg_link_proc    TEXT           NOT NULL,

	PRIMARY KEY(id)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;


-- Default template
INSERT INTO {NTUX3_DB_PREFIX}newsletters_templates (id, name, filesize, mark_newslettux, mark_footer, mark_read_site, mark_unreg_link, mark_newslettux_ad, is_dynamic, unreg_link_proc) VALUES (1, 'NewsletTux 3 SE Default Template', 726, '1', '1', '1', '1', '1', '0', '');




-- ---------------------------------------------------------------------------
-- TABLE : newsletters profiles
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}profiles (
	id             INT(10)        NOT NULL auto_increment,
	title          VARCHAR(255)   NOT NULL,
	description    VARCHAR(255)   NOT NULL,
	format         ENUM ('HTML','TEXT','mixed') NOT NULL DEFAULT 'mixed',
	send_lastnl    ENUM ('0','1') NOT NULL DEFAULT '0',
	is_openreg     ENUM ('0','1') NOT NULL DEFAULT '0',
	is_rssreadable ENUM ('0','1') NOT NULL DEFAULT '0',
	link_view      ENUM ('0','1') NOT NULL DEFAULT '1',
	display_order  TINYINT(1)     NOT NULL DEFAULT 0,

	PRIMARY KEY(id),
	UNIQUE (title)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;



-- ---------------------------------------------------------------------------
-- TABLE : writers perms
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}profiles_perms (
	id_profile      INT(10)      NOT NULL,
	id_user         INT(10)      NOT NULL,

	PRIMARY KEY(id_profile, id_user)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;



-- ---------------------------------------------------------------------------
-- TABLE : profiles subscriptions
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}profiles_regs (
	id_profile      INT(10)  NOT NULL,
	id_user         INT(10)  NOT NULL,
	datereg         DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00',
	format          ENUM('TEXT','HTML') NOT NULL DEFAULT 'HTML',

	PRIMARY KEY(id_profile, id_user)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;



-- ---------------------------------------------------------------------------
-- TABLE : templates permissions
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}users_templatesgranted (
	id_template     INT(10)  NOT NULL,
	id_user         INT(10)  NOT NULL,

	PRIMARY KEY(id_template, id_user)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;



-- ---------------------------------------------------------------------------
-- TABLE : profiles unregs
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}profiles_unregs (
	id              INT(10)             NOT NULL auto_increment,
	id_profile      INT(10)             NOT NULL,
	dateunreg       DATETIME            NOT NULL DEFAULT '2000-01-01 00:00:00',
	format          ENUM('TEXT','HTML') NOT NULL DEFAULT 'HTML',

	PRIMARY KEY(id)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;



-- ---------------------------------------------------------------------------
-- TABLE : users perms
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}usergroups_perms (
	id           INT(10)      NOT NULL auto_increment,
	groupval     ENUM('admin','writer') DEFAULT 'writer' NOT NULL,
	n3_page      VARCHAR(255) NOT NULL,
	n3_act       VARCHAR(255) NOT NULL,
	is_allowed   TINYINT(1)   NOT NULL DEFAULT 0,

	PRIMARY KEY(id)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;



-- ---------------------------------------------------------------------------
-- TABLE : subscribers (single table)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {NTUX3_DB_PREFIX}users (
	id           INT(10)      NOT NULL auto_increment,
	email        VARCHAR(50)  NOT NULL DEFAULT '',
	groupval     ENUM('root','admin','writer','subscriber') DEFAULT 'subscriber' NOT NULL,
	passwd       VARCHAR(75)  NOT NULL DEFAULT '',
	own_lang     VARCHAR(5)   NOT NULL DEFAULT 'fr',
	activatekey  VARCHAR(10)  NOT NULL DEFAULT '',
	is_activated TINYINT(1)   NOT NULL DEFAULT 0,
	datereg      DATETIME     NOT NULL DEFAULT '2000-01-01 00:00:00',
	footer       TEXT         NOT NULL,
	num_errors   INT(5)       NOT NULL DEFAULT 0,
	num_regs     INT(5)       NOT NULL DEFAULT 0,
	firstname    VARCHAR(50)  NOT NULL DEFAULT '',
	lastname     VARCHAR(50)  NOT NULL DEFAULT '',

	-- more fields
	address      VARCHAR(255) NOT NULL DEFAULT '',
	zip          VARCHAR(50)  NOT NULL DEFAULT '',
	city         VARCHAR(255) NOT NULL DEFAULT '',
	country      VARCHAR(255) NOT NULL DEFAULT '',
	phone_1      VARCHAR(50)  NOT NULL DEFAULT '',
	phone_2      VARCHAR(255) NOT NULL DEFAULT '',
	mobile       VARCHAR(50)  NOT NULL DEFAULT '',
	fax          VARCHAR(50)  NOT NULL DEFAULT '',
	company      VARCHAR(255) NOT NULL DEFAULT '',
	title        VARCHAR(255) NOT NULL DEFAULT '',


	PRIMARY KEY(id),
	UNIQUE (email)
) Engine = MyISAM CHARACTER SET utf8 COLLATE utf8_general_ci;







-- ---------------------------------------------------------------------------
-- default config
-- ---------------------------------------------------------------------------
INSERT INTO {NTUX3_DB_PREFIX}config (var, val) VALUES
-- site general config
('NTUX3_SITE_NAME', ''),
('NTUX3_SITE_URL', ''),
('NTUX3_SITE_LICENSE', 'SE'),
('NTUX3_SITE_VERSION', '310'),
('NTUX3_DEFAULT_CHMOD', ''),


-- PHP config vars
('NTUX3_PHP_FORCEFILEGETCONTENTS', 'default'),


-- interact & debug values
('NTUX3_CONF_ARRAY_DEBUG', ''),
('NTUX3_CONF_REDIRECT_AUTO', '1'),
('NTUX3_CONF_REGFORM_STYLE', 'normal'),
('NTUX3_CONF_REGFORM_URL', ''),
('NTUX3_CONF_REGFORM_VARS', ''),
('NTUX3_CONF_REGFORM_ADDFIELDS', ''),
('NTUX3_CONF_REGFORM_DOCTYPE', 'HTML'),
('NTUX3_CONF_REGFORM_ADDHTML', ''),
('NTUX3_CONF_REGFORM_ADDHTML_ERR', ''),
('NTUX3_CONF_UNREG_URL', ''),
('NTUX3_CONF_DISPLAY_UPDATES', '1'),
('NTUX3_CONF_ALERT_REG_NOTIFY', ''),
('NTUX3_CONF_LOG_ERRORS', '1'),
('NTUX3_CONF_LOG_ACTIONS', '1'),
('NTUX3_CONF_TIME_CANCEL_CRON', '5'),
('NTUX3_CONF_USER_CHECK_MAIL', '0'),
('NTUX3_CONF_AUTOCLEAN_TEMP', '1'),
('NTUX3_CONF_TIME_VALID_ACTIVATION', '72'),
('NTUX3_CONF_DISPLAY_NB_SUBS', 0),
('NTUX3_CONF_CSV_SEPARATOR', ''),
('NTUX3_CONF_RSS_URL', ''),
('NTUX3_CONF_USERS_DISPLAY_FIELDS', ''),

-- mail values
('NTUX3_MAIL_METHOD', 'mail'),
('NTUX3_MAIL_NUM_MAILS_PER_PASS', '20'),
('NTUX3_MAIL_SMTP_HOST', ''),
('NTUX3_MAIL_SMTP_PORT', '0'),
('NTUX3_MAIL_SMTP_AUTH', '1'),
('NTUX3_MAIL_SMTP_USER', ''),
('NTUX3_MAIL_SMTP_PASS', ''),
('NTUX3_MAIL_SMTP_DEBUG', '0'),
('NTUX3_MAIL_MAIL_RECEIPT', '0'),
('NTUX3_MAIL_NUM_ATTACHEMENTS', '0'),
('NTUX3_MAIL_MAX_ATTACHEMENT_SIZE', '256'),
('NTUX3_MAIL_SENDRSS_REG', '0'),
('NTUX3_MAIL_SENDER_DISPLAY', 'sender_only'),
('NTUX3_MAIL_DISPLAY_PROFILE', ''),
('NTUX3_MAIL_NOREPLY', ''),


-- misc vars
('NTUX3_MISC_NUM_ROWS_PER_PAGE', '20'),
('NTUX3_MISC_SORT_USERS', 'page'),
('NTUX3_MISC_ROOT_FORMAT', 'HTML'),

-- non editable vars
('NTUX3_HIDD_SECURE_HASH', ''),
('NTUX3_HIDD_NTUXDIR', ''),
('NTUX3_HIDD_ALL_LANGS', 'fr'),
('NTUX3_HIDD_DEFAULT_LANG', 'fr'),
('NTUX3_HIDD_ROOTID', 1),
('NTUX3_HIDD_ROOTMAIL', ''),
('NTUX3_HIDD_LASTBACKUP', ''),
('NTUX3_HIDD_USE_STRONG_PASSWD', 1);



