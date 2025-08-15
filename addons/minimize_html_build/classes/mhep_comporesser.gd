class_name MHEPCompresser

var _compressers: Array
var _copier: MHEPCopier
var _info: MHEPExportInfo
var _utils: MHEPUtils


static func compress( copier: MHEPCopier ):
	MHEPCompresser.new( copier )


func _init( copier: MHEPCopier ):
	_copier = copier
	_info = copier.info
	_utils = MHEPUtils.new( _info )
	_compressers = _get_OS_files()
	
	_debug( "- host system: " + _utils.os )
	_debug( "- compresser file: " + _compressers[0] )
	_debug( "- minifier file: " + _compressers[1] )
	
	_compress()


static func _debug( text: String ):
	MHEPUtils.debug( "COMPRESS", text )


func _compress():
	if _compressers != null:
		_copy_compressers()
		
		_process_file( _convert_to_gzip, _info.name + ".pck" )
		_process_file( _convert_to_gzip, _info.name + ".wasm" )
		_process_file( _minify, _info.name + ".html" )
		_process_file( _minify, _info.name + ".js" )
		
		_remove_compressers()
	else:
		MHEPUtils.warn( "Compresser executable is not defined. Skipping" )


func _copy_compressers():
	for filename in _compressers:
		_copier.copy_from_bin( filename )


func _remove_compressers():
	for filename in _compressers:
		_info.target_dir.remove( filename )
		
	_debug( "Build directory cleaned" )


func _get_OS_files() -> Array:
	match _utils.os:
		"Windows":
			return [ "compress.exe", "minify.exe" ]
		_:
			# TODO: Different OS compression script
			MHEPUtils.warn( "Compression is not implemented yet for host OS " + _utils.os )
			return []


func _process_file( compresser: Callable, filename: String ):
	if _compressers != null:
		var original_size = _utils.get_file_size( filename )
		
		compresser.call( filename )
		
		_info.target_dir.remove( filename )
		_info.target_dir.rename( filename + "_", filename )
		
		var new_size = _utils.get_file_size( filename )
		var diff = original_size - new_size
		
		_debug( 
				filename + 
				" converted:" + 
				" from " + MHEPUtils.string_size( original_size ) + 
				" to " + MHEPUtils.string_size( new_size ) +
				" (saved " + MHEPUtils.string_size( diff ) + ")"
		)


func _convert_to_gzip( filename: String ):
	match _utils.os:
		"Windows":
			_process_cmd_win([ "compress.exe \"" + filename + "\"" ])
		_:
			# TODO: Different OS compression script
			MHEPUtils.warn( "Compression is not implemented yet for host OS " + _utils.os )


func _minify( filename ):
	var type = filename.split(".")[-1]
	
	match type:
		"html":
			_minify_html( filename )
			
		"js":
			_minify_js( filename )
			
		_:
			MHEPUtils.warn( "Unknown file type: " + type )


func _minify_html( filename ):
	match _utils.os:
		"Windows":
			_process_cmd_win([ "minify.exe -o \"" + filename + "_\" \"" + filename + "\"" ])
		_:
			# TODO: Different OS minifying scripts
			MHEPUtils.warn( "Minifying is not implemented yet for host OS " + _utils.os )


func _minify_js( filename ):
	match _utils.os:
		"Windows":
			_process_cmd_win([ "minify.exe -o \"" + filename + "_\" \"" + filename + "\" --js-keep-var-names --js-precision 0" ])
		_:
			# TODO: Different OS minifying scripts
			MHEPUtils.warn( "Minifying is not implemented yet for host OS " + _utils.os )


func _process_cmd_win( commands ):
	var path = _info.target_dir.get_current_dir()
	var actions = commands
	
	actions.push_front( "cd " + path )
	
	# Target is on another drive
	if ":" in path:
		actions.push_front( path.split(":")[0] + ":" )
	
	OS.execute( 
			"CMD.exe", 
			[ "/C", " && ".join( actions ) ]
	)
