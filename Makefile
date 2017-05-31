
main:
	echo noop

update-plugins:
	rm -rf plugged
	PLUG_UPDATE=1 nvim -c 'PlugUpdate'

commit-plugins:
	sh others/commit-plugins.sh
