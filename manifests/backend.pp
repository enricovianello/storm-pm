# @!puppet.type.param
# @summary StoRM Backend puppet module
#
# @example Example of usage
#    class { 'storm::backend':
#      hostname => 'backend.test.example',
#      db_root_password  => 'storm',
#      db_storm_password => 'bluemoon',
#      srm_pool_members => [
#        {
#          'hostname' => 'frontend.test.example',
#        }
#      ],
#      gsiftp_pool_members => [
#        {
#          'hostname' => 'gridftp.test.example',
#        },
#      ],
#      webdav_pool_members => [
#        {
#          'hostname' => 'webdav.test.example',
#        },
#      ],
#      storage_areas => [
#        {
#          'name'               => 'test.vo',
#          'root_path'          => '/storage/test.vo',
#          'access_points'      => ['/test.vo'],
#          'vos'                => ['test.vo'],
#          'storage_class'      => 'T0D1',
#          'online_size'        => 4,
#          'transfer_protocols' => ['file', 'gsiftp', 'https'],
#        },
#      ],
#    }
#
# @param hostname
#   StoRM Backend Fully Qualified Domain Name
#
# @param install_native_libs_gpfs
#   Set this if you need to install storm-native-libs-gpfs. Default: false.
#
# @param install_mysql_and_create_database
#   Set this to true if you need to install MySQL and create StoRM database. Default: false.
#
# @param db_root_password
#   MySQL root user password
#
# @param db_storm_username
#   The name of user used to connect to local database. Default: storm
#
# @param db_storm_password
#   Password for the user in `db_storm_username`. Default: bluemoon
#
# @param xroot_hostname
#   Root server (default value for all Storage Areas).
#   Note: you may change the settings for each SA acting on its configuration.
#
# @param xroot_port
#   Root server port (default value for all Storage Areas).
#
# @param gsiftp_pool_balance_strategy
#   Load balancing strategy for GridFTP server pool (default value for all Storage Areas).
#   Note: you may change the settings for each SA acting on its configuration.
#   Available values: round-robin, smart-rr, random, weight. Default value: round-robin.
#   See [Storm::Backend::BalanceStrategy](#stormbackendbalancestrategy).
#
# @param gsiftp_pool_members
#   Array of [Storm::Backend::GsiftpPoolMember](#stormbackendgsiftppoolmember).
#   GridFTP servers pool list (default value for all Storage Areas).
#   Note: you may change the settings for each SA acting on its configuration.
#
# @param webdav_pool_members
#   Array of [Storm::Backend::WebdavPoolMember](#stormbackendwebdavpoolmember).
#   WebDAV endpoints pool list (default value for all Storage Areas).
#   Note: you may change the settings for each SA acting on its configuration.
#
# @param srm_pool_members
#   Array of [Storm::Backend::SrmPoolMember](#stormbackendsrmpoolmember).
#   Frontend endpoints pool list (default value for all Storage Areas).
#   Note: you may change the settings for each SA acting on its configuration.
#
# @param transfer_protocols
#   List of supported (and published) transfer protocols (default value for all Storage Areas). 
#   Note: you may change the settings for each SA acting on its configuration.
#
# @param fs_type
#   File System Type (default value for all Storage Areas).
#   Note: you may change the settings for each SA acting on its configuration.
#   Available values: posixfs, gpfs and test. Default value: posixfs
#   See [Storm::Backend::FsType](#stormbackendfstype).
#
# @param storage_areas
#   List of supported Storage Areas.
#   Array of [Storm::Backend::StorageArea](#stormbackendstoragearea).
#
# @param frontend_public_host
#   StoRM Frontend service public host. It’s used by StoRM Info Provider to publish the SRM endpoint into the Resource BDII.
#   Default value: `hostname`
#
# @param frontend_port
#   StoRM Frontend service port. Default value: 8444
#
# @param directory_automatic_creation
#   Flag to enable automatic missing directory creation upon srmPrepareToPut requests. Default: false.
#
# @param directory_writeperm
#   Flag to enable directory write permission setting upon srmMkDir requests on created directories. Default: false.
#
# @param rest_services_port
#   REST services port. Default value: 9998
#
# @param rest_services_max_threads
#   REST services max active requests. Default: 100
#   
# @param rest_services_max_queue_size
#   REST services max queue size of accepted requests. Default: 1000
#
# @param xmlrpc_unsecure_server_port
#   Port to listen on for incoming XML-RPC connections from Frontends(s). Default: 8080
#
# @param xmlrpc_maxthread
#   Number of threads managing XML-RPC connection from Frontends(s).
#   A well sized value for this parameter have to be at least equal to the sum of the number of working threads in all Frontends.
#   Default: 100.
#
# @param xmlrpc_max_queue_size
#   Max number of accepted and queued XML-RPC connection from Frontends(s). Default: **1000**
#
# @param xmlrpc_security_enabled
#   Whether the backend will require a token to be present for accepting XML-RPC requests. Default: true.
#
# @param xmlrpc_security_token
#   The token that the backend will require to be present for accepting XML-RPC requests.
#   Mandatory if xmlrpc_security_enabled is true.
#
# @param ptg_skip_acl_setup
#   Skip ACL setup for PtG requests. Default: false.
#
# @param pinlifetime_default
#   Default PinLifetime in seconds used for pinning files in case of srmPrepareToPut or srmPrepareToGet operation
#   without any pinLifetime specified. Default: 259200.
#
# @param pinlifetime_maximum
#   Maximum PinLifetime allowed in seconds. Default: 1814400.
#
# @param sanity_check_enabled
#   Enable/disable sanity checks during bootstrap phase. Default: true.
#
# @param service_du_enabled
#   Flag to enable disk usage service. Default: false.
#
# @param service_du_delay
#   The initial delay before the service is started (seconds). Default: 60.
#
# @param service_du_interval
#   The interval in seconds between successive run. Default: 360.
#
# @param max_ls_entries
#   Maximum number of entries returned by an srmLs call.
#   Since in case of recursive srmLs results can be in order of million, this prevent a server overload. Default: 500.
#
# @param gc_pinnedfiles_cleaning_delay
#   Initial delay before starting the reserved space, JIT ACLs and pinned files garbage collection process, in seconds. Default: 10.
#
# @param gc_pinnedfiles_cleaning_interval
#   Time interval in seconds between successive purging run. Default: 300.
#
# @param gc_purge_enabled
#   Enable the request garbage collector. Default: true.
#
# @param gc_purge_interval
#   Time interval in seconds between successive purging run. Default: 600.
#
# @param gc_purge_size
#   Number of requests picked up for cleaning from the requests garbage collector at each run.
#   This value is use also by Tape Recall Garbage Collector. Default: 800
#
# @param gc_expired_request_time
#   Time in seconds to consider a request expired after its submission. Default: 604800 seconds (1 week).
#   From StoRM 1.11.13 it is used also to identify how much time is needed to consider a completed recall task as cleanable.
#
# @param gc_expired_inprogress_time
#   Time in seconds to consider an in-progress ptp request as expired. Default: 2592000 seconds (1 month).
#
# @param gc_ptp_transit_interval
#   Time interval in seconds between successive expired put requests agent run. Default: 3000.
#
# @param gc_ptp_transit_start_delay
#   Initial delay before starting the expired put requests agent process, in seconds. Default: 60
#
# @param extraslashes_file
#   Add extra slashes after the “authority” part of a TURL for file protocol. Defaul: ''
#
# @param extraslashes_root
#   Add extra slashes after the “authority” part of a TURL for xroot protocol. Default: '/'
#
# @param extraslashes_gsiftp
#   Add extra slashes after the “authority” part of a TURL for gsiftp protocol. Default: '/'
#
# @param db_connection_pool_enabled
#   Enable the database connection pool. Default: true
#
# @param db_connection_pool_max_active
#   Database connection pool max active connections. Default: 10
#
# @param db_connection_pool_max_wait
#   Database connection pool max wait time to provide a connection. Default: 50
#
# @param asynch_db_reconnect_period
#   Database connection refresh time intervall in seconds. Default: 18000
#
# @param asynch_db_delay_period
#   Database connection refresh initial delay in seconds. Default: 30.
#
# @param asynch_picking_initial_delay
#   Initial delay before starting to pick requests from the DB, in seconds. Default: 1.
#
# @param asynch_picking_time_interval
#   Polling interval in seconds to pick up new SRM requests. Default: 2.
#
# @param asynch_picking_max_batch_size
#   Maximum number of requests picked up at each polling time. Default: 100.
#
# @param requests_scheduler_core_size
#   Crusher Scheduler worker pool base size. Default: 50.
#
# @param requests_scheduler_max_size
#   Crusher Schedule worker pool max size. Default: 200.
#
# @param requests_scheduler_queue_size
#   Request queue maximum size. Default: 2000.
#
# @param ptp_requests_scheduler_core_size
#   PrepareToPut worker pool base size. Default: 50.
#
# @param ptp_requests_scheduler_max_size
#   PrepareToPut worker pool max size. Default: 200.
#
# @param ptp_requests_scheduler_queue_size
#   PrepareToPut request queue maximum size. Default: 1000.
#
# @param ptg_requests_scheduler_core_size
#   PrepareToGet worker pool base size. Default: 50.
#
# @param ptg_requests_scheduler_max_size
#   PrepareToGet worker pool max size. Default: 200.
#
# @param ptg_requests_scheduler_queue_size
#   PrepareToGet request queue maximum size. Default: 2000.
#
# @param bol_requests_scheduler_core_size
#   BringOnline worker pool base size. Default: 50.
#
# @param bol_requests_scheduler_max_size
#   BringOnline Worker pool max size. Default: 200.
#
# @param bol_requests_scheduler_queue_size
#   BringOnline request queue maximum size. Default: 2000.
#
# @param info_sitename
#   It’s the human-readable name of your site used to set the Glue-SiteName attribute.
#
# @param info_storage_default_root
#   Default directory for Storage Areas.
#
# @param info_endpoint_quality_level
#   Endpoint maturity level to be published by the StoRM info provider. Default value: 2.
#
# @param info_webdav_pool_list
#   List of published webdav endpoints.
#
# @param info_frontend_host_list
#   List of published srm endpoints.
#
class storm::backend (

  String $hostname,

  # Install native libs gpfs
  Boolean $install_native_libs_gpfs = $storm::backend::params::install_native_libs_gpfs,

  # Install MySQL and/or create database
  Boolean $install_mysql_and_create_database = $storm::backend::params::install_mysql_and_create_database,
  String $db_root_password = $storm::backend::params::db_root_password,
  # Db connection
  String $db_storm_username = $storm::backend::params::db_storm_username,
  String $db_storm_password = $storm::backend::params::db_storm_password,

  ### Default values for Storage Areas
  # 1. xroot
  String $xroot_hostname = lookup('storm::backend::xroot_hostname', String, undef, $hostname),
  Integer $xroot_port = $storm::backend::params::xroot_port,
  # 2. gridftp pool
  Storm::Backend::BalanceStrategy $gsiftp_pool_balance_strategy = $storm::backend::params::gsiftp_pool_balance_strategy,
  Array[Storm::Backend::GsiftpPoolMember] $gsiftp_pool_members = $storm::backend::params::gsiftp_pool_members,
  # 3. webdav pool
  Array[Storm::Backend::WebdavPoolMember] $webdav_pool_members = $storm::backend::params::webdav_pool_members,
  # 4. frontend pool
  Array[Storm::Backend::SrmPoolMember] $srm_pool_members = $storm::backend::params::srm_pool_members,
  # 5. transfer protocols
  Array[Storm::Backend::TransferProtocol] $transfer_protocols = $storm::backend::params::transfer_protocols,
  # 6. fs-type
  Storm::Backend::FsType $fs_type = $storm::backend::params::fs_type,

  # Storage Areas
  Array[Storm::Backend::StorageArea] $storage_areas = $storm::backend::params::storage_areas,

  # Frontend public host and port
  String $frontend_public_host = lookup('storm::backend::srm_hostname', String, undef, $hostname),
  Integer $frontend_port = $storm::backend::params::frontend_port,

  # Directory options
  Boolean $directory_automatic_creation = $storm::backend::params::directory_automatic_creation,
  Boolean $directory_writeperm = $storm::backend::params::directory_writeperm,

  # REST server conf
  Integer $rest_services_port = $storm::backend::params::rest_services_port,
  Integer $rest_services_max_threads = $storm::backend::params::rest_services_max_threads,
  Integer $rest_services_max_queue_size = $storm::backend::params::rest_services_max_queue_size,

  # XMLRPC Server parameter
  Integer $xmlrpc_unsecure_server_port = $storm::backend::params::xmlrpc_unsecure_server_port,
  Integer $xmlrpc_maxthread = $storm::backend::params::xmlrpc_maxthread,
  Integer $xmlrpc_max_queue_size = $storm::backend::params::xmlrpc_max_queue_size,
  Boolean $xmlrpc_security_enabled = $storm::backend::params::xmlrpc_security_enabled,
  String $xmlrpc_security_token = $storm::backend::params::xmlrpc_security_token,

  # Skip ACL setup for PTG requests
  Boolean $ptg_skip_acl_setup = $storm::backend::params::ptg_skip_acl_setup,

  # Pin lifetime
  Integer $pinlifetime_default = $storm::backend::params::pinlifetime_default,
  Integer $pinlifetime_maximum = $storm::backend::params::pinlifetime_maximum,

  # Sanity checks
  Boolean $sanity_check_enabled = $storm::backend::params::sanity_check_enabled,

  # DU service
  Boolean $service_du_enabled = $storm::backend::params::service_du_enabled,
  Integer $service_du_delay = $storm::backend::params::service_du_delay,
  Integer $service_du_interval = $storm::backend::params::service_du_interval,

  # Ls max entries
  Integer $max_ls_entries = $storm::backend::params::max_ls_entries,

  # Pinned Files cleaning parameters
  Integer $gc_pinnedfiles_cleaning_delay = $storm::backend::params::gc_pinnedfiles_cleaning_delay,
  Integer $gc_pinnedfiles_cleaning_interval = $storm::backend::params::gc_pinnedfiles_cleaning_interval,

  # Garbage Collector
  Boolean $gc_purge_enabled = $storm::backend::params::gc_purge_enabled,
  Integer $gc_purge_interval = $storm::backend::params::gc_purge_interval,
  Integer $gc_purge_size = $storm::backend::params::gc_purge_size,
  Integer $gc_expired_request_time = $storm::backend::params::gc_expired_request_time,
  Integer $gc_expired_inprogress_time = $storm::backend::params::gc_expired_inprogress_time,
  Integer $gc_ptp_transit_interval = $storm::backend::params::gc_ptp_transit_interval,
  Integer $gc_ptp_transit_start_delay = $storm::backend::params::gc_ptp_transit_start_delay,

  # Extraslashes
  String $extraslashes_file = $storm::backend::params::extraslashes_file,
  String $extraslashes_root = $storm::backend::params::extraslashes_root,
  String $extraslashes_gsiftp = $storm::backend::params::extraslashes_gsiftp,

  # Db Connection Pool
  Boolean $db_connection_pool_enabled = $storm::backend::params::db_connection_pool_enabled,
  Integer $db_connection_pool_max_active = $storm::backend::params::db_connection_pool_max_active,
  Integer $db_connection_pool_max_wait = $storm::backend::params::db_connection_pool_max_wait,

  # Asynch Picker
  Integer $asynch_db_reconnect_period = $storm::backend::params::asynch_db_reconnect_period,
  Integer $asynch_db_delay_period = $storm::backend::params::asynch_db_delay_period,
  Integer $asynch_picking_initial_delay = $storm::backend::params::asynch_picking_initial_delay,
  Integer $asynch_picking_time_interval = $storm::backend::params::asynch_picking_time_interval,
  Integer $asynch_picking_max_batch_size = $storm::backend::params::asynch_picking_max_batch_size,

  # Requests schedulers
  Integer $requests_scheduler_core_size = $storm::backend::params::requests_scheduler_core_size,
  Integer $requests_scheduler_max_size = $storm::backend::params::requests_scheduler_max_size,
  Integer $requests_scheduler_queue_size = $storm::backend::params::requests_scheduler_queue_size,
  Integer $ptp_requests_scheduler_core_size = $storm::backend::params::ptp_requests_scheduler_core_size,
  Integer $ptp_requests_scheduler_max_size = $storm::backend::params::ptp_requests_scheduler_max_size,
  Integer $ptp_requests_scheduler_queue_size = $storm::backend::params::ptp_requests_scheduler_queue_size,
  Integer $ptg_requests_scheduler_core_size = $storm::backend::params::ptg_requests_scheduler_core_size,
  Integer $ptg_requests_scheduler_max_size = $storm::backend::params::ptg_requests_scheduler_max_size,
  Integer $ptg_requests_scheduler_queue_size = $storm::backend::params::ptg_requests_scheduler_queue_size,
  Integer $bol_requests_scheduler_core_size = $storm::backend::params::bol_requests_scheduler_core_size,
  Integer $bol_requests_scheduler_max_size = $storm::backend::params::bol_requests_scheduler_max_size,
  Integer $bol_requests_scheduler_queue_size = $storm::backend::params::bol_requests_scheduler_queue_size,

  # Info Provider
  String $info_config_file = $storm::backend::params::info_config_file,
  String $info_sitename = $storm::backend::params::info_sitename,
  String $info_storage_default_root = $storm::backend::params::info_storage_default_root,
  Integer $info_endpoint_quality_level = $storm::backend::params::info_endpoint_quality_level,
  Array[Storm::Backend::WebdavPoolMember] $info_webdav_pool_list = lookup('storm::backend::info_webdav_pool_list',
    Array[Storm::Backend::WebdavPoolMember], undef, $webdav_pool_members),
  Array[Storm::Backend::SrmPoolMember] $info_frontend_host_list = lookup('storm::backend::info_frontend_host_list',
    Array[Storm::Backend::SrmPoolMember], undef, $srm_pool_members),

) inherits storm::backend::params {

  contain storm::backend::install
  contain storm::backend::config
  contain storm::backend::service

  Class['storm::backend::install']
  -> Class['storm::backend::config']
  -> Class['storm::backend::service']
}
