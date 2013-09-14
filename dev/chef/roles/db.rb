name "db"
description 'Dev postgres instance'
run_list(
    'recipe[apt]',
    'recipe[postgresql::server]'
)
