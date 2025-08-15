class_name MinimizeHTMLExportPlugin
extends EditorExportPlugin

var _plugin_name = "Minimize HTML Build"
var _export_info: MHEPExportInfo


func _get_name() -> String:
	return _plugin_name


func _supports_platform( platform: EditorExportPlatform ) -> bool:
	return ( platform is EditorExportPlatformWeb )


func _export_begin( 
		_features: PackedStringArray, 
		is_debug: bool, 
		path: String, 
		_flags: int 
):
	MHEPUtils.enable_debug( is_debug )
	MHEPUtils.debug( "", "---- EXPORT STARTED ----" )
	
	_export_info = MHEPExportInfo.new( path )


func _export_end():
	# Run compression after all project files were created
	var copier = MHEPCopier.new( _export_info )
	
	MHEPCompresser.compress( copier )
	MHEPHTML.fix( _export_info )
	MHEPJS.fix( _export_info )
	MHEPUtils.debug( "", "---- EXPORT FINISHED ----" )
