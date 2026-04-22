/************************************************************************************************************
** Optionales Projektskript ausfuehren
*************************************************************************************************************/

define optional_runner = /tmp/b3m_run_optional.sql

host if [ -f "&optional_script." ]; then printf '@&optional_script.\n' > &optional_runner.; elif [ -f "&optional_script..sql" ]; then printf '@&optional_script.\n' > &optional_runner.; else printf '@&help_dir.optional_missing\n' > &optional_runner.; fi

@&optional_runner.
