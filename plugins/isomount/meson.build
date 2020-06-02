isomount_dir = join_paths(plugin_dir, 'core')

shared_module(
    'pantheon-files-isomount',
    'plugin.vala',
    dependencies: [pantheon_files_core_dep],
    install: true,
    install_dir: isomount_dir
)

install_data(
    'pantheon-files-isomount.plug',
    install_dir: isomount_dir
)
