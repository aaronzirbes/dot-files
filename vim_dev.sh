# General functions
function failed_test_classes() {
    grep -B 1 -E '(<error|<failure)' target/test-reports/TESTS-TestSuites.xml \
        |grep -E '^ *<testcase' \
        |sed -e 's/.* classname="//' \
        |sed -e 's/".*//' \
        |sort -u
}


function _editor_failed() {
	if [ -r application.properties ]; then
        editor="$1"
		files=""
        for classpath in `failed_test_classes`; do
			class="${classpath/[0-9A-Za-z.]*\.}"
			package="${classpath/.$class}"
			new_files=`find . -name "${class}.groovy"`
			files="$files $new_files"
		done
		if [ "$files" != "" ]; then
			${editor} $files
		fi
	fi
}

function _editor_modified() {
    editor="$1"
    # if the current folder is in a git repo...
    if (git status -s 2> /dev/null >/dev/null); then
        # get a list of modified files that actually exist
        modified_files=$(for foo in `git diff --relative --name-only HEAD^`; do if [ -e $foo ]; then echo $foo; fi; done)
        echo "${editor} ${modified_files}"
        echo ""
        ${editor} ${modified_files}
	fi
}

# Editor specific implementations

function mvim_modified() {
    _editor_modified mvim
}

function vim_modified() {
    _editor_modified vim
}

function nvim_modified() {
    _editor_modified nvim
}

function vim_failed() {
    _editor_failed vim
}

function mvim_failed() {
    _editor_failed mvim
}

function nvim_failed() {
    _editor_failed nvim
}

