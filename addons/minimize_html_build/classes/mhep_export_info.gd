class_name MHEPExportInfo

const delimiter = "/"

var name = "unknown"
var path = "./"

var local_dir: DirAccess
var target_dir: DirAccess


func _init( fullPath: String ):
	_extract_path_info( fullPath )
	
	local_dir = DirAccess.open( "." )
	target_dir = DirAccess.open( path )


func in_local_dir( relative: String ) -> String:
	return local_dir.get_current_dir() + delimiter + relative


func in_addon_dir( relative: String ) -> String:
	return in_local_dir( "addons/minimize_html_build/" + relative )


func in_target_dir( relative: String ) -> String:
	return target_dir.get_current_dir() + delimiter + relative


static func _debug( text: String ):
	MHEPUtils.debug( "INFO", text )


func _extract_path_info( fullPath: String ):
	var split: PackedStringArray = fullPath.split( delimiter )
	
	path = delimiter.join( split.slice( 0, -1 ))
	name = ".".join(split[-1].split( "." ).slice(0,-1))
	
	_debug( "Export data fetched:" )
	_debug( "- path is \"" + path + "\"" )
	_debug( "- main file is \"" + name + "\"" )
