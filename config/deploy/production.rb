# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

server "thecloud2.mycpnv.ch", user: "maw11_11", ssh_options: {
  user: 'maw11_11',
  keys: %w(~/.ssh/id_rsa),
  forward_agent: false,
  auth_methods: %w(publickey)
}

task :copy_dotenv do
  on roles(:all) do
    execute :cp, "#{shared_path}/.env #{release_path}/.env"
  end
end

set :laravel_version, 8.0
set :laravel_upload_dotenv_file_on_deploy, false
# swisscenter disables acls, instead use chmod
set :laravel_set_acl_paths, false

after 'composer:run', 'copy_dotenv'
after 'composer:run', 'laravel:migrate'

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.
