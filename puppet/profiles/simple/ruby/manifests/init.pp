# *************************
# Simple rbenv-ruby profile
# *************************
#
# rbenv and ruby version parameters for the rbenv module
#
# Hiera parameters:
#
# rbenv::install:
#   user:  'simple_web_app'
#   group:  'simple_web_app'
#   home:  '/home/simple_web_app'
# rbenv::compile:
#   "1.9.3-p327":
#       user:  "simple_web_app"
#       home:  "/home/simple_web_app"
#       global:  true

class profiles::simple::ruby {

  # ***********************************
  # Obtain and install rbenv from hiera
  # ***********************************
  $rbenv_install_hash = { 'rbenv_install' => hiera('rbenv::install', {}) }
  create_resources('rbenv::install', $rbenv_install_hash)

  # *******************************************
  # Obtain and compile ruby versions from hiera
  # *******************************************
  $rbenv_compile_hash = hiera('rbenv::compile', {})
  create_resources('rbenv::compile', $rbenv_compile_hash)
}