let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Sites/sesh
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +13 ~/Sites/zip_search/zip_search.gemspec
badd +1 ~/Sites/zip_search/app/models/zip_search/zip_search.rb
badd +1 ~/Sites/zip_search/app/models/zip_search/location.rb
badd +8 ~/Sites/zip_search/lib/zip_search.rb
badd +7 ~/Sites/zip_search/lib/zip_search/engine.rb
badd +1 ~/Sites/zip_search/lib/zip_search/railtie.rb
badd +4 ~/Sites/zip_search/lib/zip_search/model_helpers.rb
badd +5 ~/Sites/zip_search/lib/zip_search/acts_as_location.rb
badd +5 ~/Sites/zip_search/lib/zip_search/strong_params_helper.rb
badd +4 ~/Sites/zip_search/test/dummy/config/routes.rb
badd +1 ~/Sites/zip_search/test/dummy/app/views/main/home.html.erb
badd +1 ~/Sites/zip_search/lib/zip_search/view_helpers.rb
badd +1 \'/Users/smit1625/Sites/zip_search/app/views/zip_search/locations/_search_field.html.erb\'
badd +9 ~/Sites/zip_search/app/views/zip_search/locations/_search_field.html.erb
badd +8 ~/Sites/zip_search/Gemfile
badd +8 ~/Sites/zip_search/app/assets/javascripts/zip_search/locations.coffee
badd +3 ~/Sites/zip_search/config/routes.rb
badd +1 ~/Sites/zip_search/test/dummy/app/assets/javascripts/application.js
badd +1 ~/Sites/zip_search/app/views/layouts/zip_search/application.html.erb
badd +1 ~/Sites/zip_search/test/dummy/app/views/layouts/application.html.erb
badd +1 \'/Users/smit1625/Sites/zip_search/app/assets/javascripts/zip_search/init.js\'
badd +3 ~/Sites/zip_search/app/controllers/zip_search/locations_controller.rb
badd +1 ~/Sites/zip_search/test/dummy/config/database.yml
badd +17 ~/Sites/zip_search/app/assets/stylesheets/zip_search/typeahead.scss
badd +1 ~/Sites/zip_search/test/dummy/app/models/house.rb
badd +14 ~/Sites/zip_search/test/dummy/app/controllers/houses_controller.rb
badd +1 ~/Sites/zip_search/test/dummy/app/views/houses/new.html.erb
badd +7 ~/Sites/zip_search/test/dummy/app/views/houses/_form.html.erb
badd +5 ~/Sites/zip_search/lib/zip_search/has_locations.rb
badd +1 ~/Sites/zip_search/test/dummy/config/environments/development.rb
badd +1 \'/Users/smit1625/Sites/zip_search/config/spring.rb\'
badd +1 ~/Sites/zip_search/config/spring.rb
badd +1 ~/Sites/zip_search/test/dummy/config/spring.rb
badd +1 ~/Sites/zip_search/config/application.rb
badd +1 ~/Sites/zip_search/test/dummy/config/application.rb
badd +1 ~/Sites/zip_search/test/dummy/Guardfile
badd +82 ~/Sites/zip_search/Guardfile
badd +1 \'/Users/smit1625/Sites/zip_search/zeus.json\'
badd +1 ~/Sites/zip_search/zeus.json
badd +1 \'/Users/smit1625/Sites/zip_search/engine_plan.rb\'
badd +1 ~/Sites/zip_search/engine_plan.rb
badd +10 ~/Sites/zip_search/lib/zip_search/controller_helpers.rb
badd +14 ~/Sites/zip_search/test/dummy/app/views/houses/show.html.erb
badd +1 ~/Sites/zip_search/app/assets/javascripts/zip_search/init.js
badd +6 ~/Sites/zip_search/lib/zip_search/simple_form_helper.rb
badd +1 \'/Users/smit1625/Sites/zip_search/app/views/zip_search/_simple_fields.html.erb\'
badd +1 ~/Sites/zip_search/app/views/zip_search/_simple_fields.html.erb
badd +3 lib/sesh/version.rb
badd +1 ~/Sites/energy_innovation_award/index.html
badd +1 ~/Sites/energy_innovation_award/css/custom.css
badd +1 ~/Sites/energy_innovation_award/about.html
badd +1 ~/Sites/energy_innovation_award/contact.html
badd +1 ~/Sites/energy_innovation_award/form2.html
badd +1 ~/Sites/energy_innovation_award/news.html
badd +1 ~/Sites/energy_innovation_award/privacy-statement.html
badd +1 ~/Sites/energy_innovation_award/register.html
badd +1 ~/Sites/energy_innovation_award/site-accessibility.html
badd +1 ~/Sites/vrat/spec/spec_helper.rb
badd +1 ~/Sites/theriverboat_v2/db/schema.rb
badd +1 ~/Sites/theriverboat_v2/app/models/ticket.rb
badd +1 ~/Sites/theriverboat_v2/app/models/payment.rb
badd +1 ~/Sites/theriverboat_v2/Gemfile
badd +1 ~/Sites/theriverboat_v2/app/controllers/payments_controller.rb
badd +1 ~/Sites/theriverboat_v2/app/views/tickets/new.html.haml
badd +1 ~/Sites/theriverboat_v2/app/controllers/tickets_controller.rb
badd +1 ~/Sites/theriverboat_v2/app/views/tickets/_payment_errors.html.haml
badd +1 ~/Sites/theriverboat_v2/app/assets/javascripts/payments.js.coffee
badd +1 ~/Sites/theriverboat_v2/app/assets/javascripts/tickets.js.coffee
badd +1 ~/Sites/theriverboat_v2/app/assets/stylesheets/bootstrap-overrides.scss
badd +1 ~/Sites/theriverboat_v2/app/assets/javascripts/shared.js.coffee
badd +1 ~/Sites/theriverboat_v2/app/assets/javascripts/home.js.coffee
badd +1 ~/Sites/theriverboat_v2/app/assets/javascripts/event_booking_categories.js.coffee
badd +1 ~/Sites/theriverboat_v2/app/assets/javascripts/event_bookings.js.coffee
badd +1 ~/Sites/theriverboat_v2/app/views/layouts/application.html.haml
badd +1 ~/Sites/theriverboat_v2/app/assets/javascripts/admin/users.js.coffee
badd +1 ~/Sites/theriverboat_v2/app/helpers/application_helper.rb
badd +1 ~/Sites/theriverboat_v2/app/controllers/contact_messages_controller.rb
badd +1 ~/Sites/theriverboat_v2/app/controllers/application_controller.rb
badd +1 ~/Sites/theriverboat_v2/app/controllers/concerns/recaptcha_verification.rb
badd +1 ~/Sites/theriverboat_v2/app/controllers/event_bookings_controller.rb
badd +1 ~/Sites/theriverboat_v2/app/views/event_bookings/new.html.haml
badd +1 ~/Sites/theriverboat_v2/app/views/event_bookings/_form.html.haml
badd +1 ~/Sites/theriverboat_v2/spec/helpers/payments_helper_spec.rb
badd +1 ~/Sites/theriverboat_v2/spec/features/events_spec.rb
badd +1 ~/Sites/theriverboat_v2/spec/features/tickets_spec.rb
badd +1 ~/Sites/theriverboat_v2/spec/models/ticket_spec.rb
badd +1 ~/Sites/theriverboat_v2/spec/models/users_spec.rb
badd +1 ~/Sites/theriverboat_v2/spec/factories/tickets.rb
badd +1 ~/Sites/theriverboat_v2/spec/factories/payments.rb
badd +1 ~/Sites/theriverboat_v2/app/models/user.rb
badd +1 ~/Sites/theriverboat_v2/spec/controllers/tickets_controller_spec.rb
badd +1 ~/Sites/theriverboat_v2/spec/controllers/admin/tickets_controller_spec.rb
badd +1 ~/Sites/theriverboat_v2/spec/features/users_spec.rb
badd +1 ~/Sites/theriverboat_v2/app/controllers/admin/tickets_controller.rb
badd +1 ~/Sites/theriverboat_v2/spec/features/twilio_spec.rb
badd +1 ~/Sites/theriverboat_v2/app/controllers/twilio_controller.rb
badd +1 ~/Sites/theriverboat_v2/config/routes.rb
badd +1 ~/Sites/theriverboat_v2/spec/features/event_bookings_spec.rb
badd +1 ~/Sites/theriverboat_v2/spec/spec_helper.rb
badd +1 ~/.rvm/gems/ruby-2.1.0/gems/devise-3.2.4/lib/devise/test_helpers.rb
badd +1 ~/Sites/theriverboat_v2/spec/support/features/devise_helpers.rb
badd +1 ~/Sites/theriverboat_v2/spec/models/payment_spec.rb
badd +1 ~/Sites/theriverboat_v2/app/models/admin/activity.rb
badd +1 ~/Sites/theriverboat_v2/spec/factories/users.rb
badd +1 ~/Sites/theriverboat_v2/spec/factories/events.rb
badd +1 ~/Sites/theriverboat_v2/config/secrets.yml
badd +1 ~/Sites/theriverboat_v2/config/initializers/stripe.rb
badd +1 ~/Sites/theriverboat_v2/app/views/admin/events/_form.html.haml
badd +1 ~/Sites/theriverboat_v2/app/assets/javascripts/application.js
badd +1 ~/Sites/theriverboat_v2/app/assets/javascripts/admin/events.js.coffee
badd +1 ~/Sites/theriverboat_v2/app/views/ticket_codes/_cocoon_table.html.haml
badd +1 ~/Sites/theriverboat_v2/app/views/tickets/_ticket_code_fields.html.haml
badd +1 ~/Sites/theriverboat_v2/app/views/payments/_card_storage_fields.html.haml
badd +1 ~/Sites/theriverboat_v2/app/helpers/tickets_helper.rb
badd +1 ~/Sites/theriverboat_v2/app/helpers/events_helper.rb
badd +1 ~/Sites/theriverboat_v2/app/helpers/admin/users_helper.rb
badd +1 ~/Sites/theriverboat_v2/app/helpers/refund_requests_helper.rb
badd +1 ~/Sites/theriverboat_v2/app/models/ticket_code.rb
badd +1 ~/Sites/theriverboat_v2/app/views/admin/tickets/_table_row.html.haml
badd +1 ~/Sites/theriverboat_v2/app/models/event.rb
badd +1 ~/Sites/theriverboat_v2/app/views/devise/passwords/new.html.haml
badd +1 ~/Sites/theriverboat_v2/app/views/devise/sessions/new.html.haml
badd +1 ~/Sites/theriverboat_v2/app/views/devise/passwords/edit.html.haml
badd +1 ~/Sites/theriverboat_v2/test/fixtures/users.yml
badd +1 ~/Sites/theriverboat_v2/spec/controllers/twilio_controller_spec.rb
badd +1 ~/Sites/theriverboat_v2/spec/factories/event_bookings.rb
badd +1 ~/Sites/theriverboat_v2/spec/factories/promo_codes.rb
badd +1 ~/Sites/theriverboat_v2/app/views/admin/tickets/checkin.html.haml
badd +1 ~/Sites/theriverboat_v2/app/mailers/base_mailer.rb
badd +1 ~/Sites/theriverboat_v2/config/schedule.rb
badd +1 ~/Sites/theriverboat_v2/config/environments/development.rb
badd +1 ~/Sites/theriverboat_v2/app/models/site_configuration.rb
badd +1 ~/Sites/theriverboat_v2/db/migrate/20140618143026_add_google_credentials_to_site_configurations.rb
badd +1 ~/Sites/theriverboat_v2/app/controllers/site_configurations_controller.rb
badd +1 ~/Sites/theriverboat_v2/app/controllers/admin/site_configurations_controller.rb
badd +1 ~/Sites/theriverboat_v2/app/views/admin/activities/index.html.haml
badd +1 ~/Sites/theriverboat_v2/app/views/admin/events/index.html.haml
badd +1 ~/Sites/theriverboat_v2/app/views/shared/_date_range_filter.html.haml
badd +1 ~/Sites/theriverboat_v2/app/assets/javascripts/daterangepicker.js
badd +1 ~/Sites/theriverboat_v2/app/assets/javascripts/moment-duration-format.js
badd +1 ~/Sites/theriverboat_v2/app/assets/stylesheets/daterangepicker-bs3.css
badd +1 ~/Sites/theriverboat_v2/app/assets/stylesheets/application.css
badd +1 ~/Sites/theriverboat_v2/app/controllers/admin/activities_controller.rb
badd +1 ~/Sites/theriverboat_v2/spec/factories/photos.rb
badd +1 ~/Sites/theriverboat_v2/Gemfile.lock
badd +1 ~/Sites/theriverboat_v2/config/initializers/simple_form_fileinput.rb
badd +1 ~/Sites/InquireTi/app_src/controllers/index.coffee
badd +1 ~/Sites/InquireTitanium/app_src/controllers/index.coffee
badd +1 ~/Sites/InquireTitanium/app_src/views/index.haml
badd +1 ~/Sites/InquireTitanium/app_src/controllers/login.coffee
badd +1 ~/Sites/InquireTitanium/app_src/views/login.haml
badd +1 ~/Sites/InquireTitanium/app/views/index.xml
badd +1 ~/dotfiles/tmuxinator/InquireTitanium.yml
badd +1 ~/Sites/InquireTitanium/\[Vundle]\ Installer
badd +1 ~/Sites/InquireTitanium/app/views/login.xml
badd +1 ~/Sites/InquireTitanium/app/styles/app.tss
badd +1 ~/Sites/InquireTitanium/app_src/styles/login.tss.coffee
badd +1 ~/Sites/InquireTitanium/app/styles/login.tss.js
badd +1 ~/Sites/InquireTitanium/app/styles/login.tss
badd +1 ~/Sites/InquireTitanium/app/controllers/login.js
badd +1 ~/Sites/InquireTitanium/app/controllers/index.js
badd +1 ~/Sites/InquireTitanium/app_src/controllers/app.coffee
badd +1 ~/Sites/InquireTitanium/app/controllers/app.js
badd +1 ~/Sites/InquireTitanium/app/alloy.js
badd +1 \'/Users/smit1625/Sites/InquireTitanium/app_src/migrations/201507190000000_users.coffee\'
badd +1 \'/Users/smit1625/Sites/InquireTitanium/app_src/models/users.coffee\'
badd +1 ~/Sites/InquireTitanium/app_src/models/users.coffee
badd +1 ~/Sites/InquireTitanium/app_src/migrations/20150719000000_api_keys.coffee
badd +1 \'/Users/smit1625/Sites/InquireTitanium/app_src/models/api_keys.coffee\'
badd +1 ~/Sites/InquireTitanium/app_src/models/api_keys.coffee
badd +1 \'/Users/smit1625/Sites/InquireTitanium/app_src/migrations/20150719172900_users.coffee\'
badd +1 ~/Sites/InquireTitanium/app_src/migrations/20150719172900_users.coffee
badd +1 \'/Users/smit1625/Sites/InquireTitanium/app_src/migrations/20150719000000_api_keys.coffee\'
badd +1 ~/Sites/InquireTitanium/app/styles/index.tss
badd +1 ~/Sites/InquireTitanium/app_src/styles/index.tss.coffee
badd +1 ~/Sites/InquireTitanium/app/config.json
badd +1 ~/Sites/InquireTitanium/app/README
badd +1 \'/Users/smit1625/Sites/InquireTitanium/app/lib/cryptojs-sha1.js\'
badd +1 \'/Users/smit1625/Sites/InquireTitanium/app/assets/components/cryptojs-base64.js\'
badd +1 ~/Sites/InquireTitanium/app/assets/components/crypto-sha1.js
badd +1 ~/Sites/InquireTitanium/app_src/models/questions.coffee
badd +1 ~/Sites/InquireTi/app/alloy.js
badd +1 ~/Sites/InquireTi/app_src/controllers/app.coffee
badd +1 ~/Sites/InquireTi/app/styles/login.tss
badd +1 ~/Sites/InquireTi/app_src/styles/login.tss.coffee
badd +1 ~/Sites/InquireTi/app_src/controllers/login.coffee
badd +1 ~/Sites/InquireTi/app_src/models/users.coffee
badd +1 ~/Sites/InquireTitanium/tiapp.xml
badd +1 ~/Sites/InquireTitanium/Resources/app.js
badd +1 ~/Sites/InquireTi/app_src/models/api_keys.coffee
badd +1 ~/Sites/InquireTi/app_src/styles/index.tss.coffee
badd +1 ~/Sites/InquireTi/app_src/styles/app.tss.coffee
badd +1 ~/Sites/InquireTi/app_src/views/index.haml
badd +1 \'/Users/smit1625/Sites/InquireTi/app_src/views/questions.haml\'
badd +1 ~/Sites/InquireTi/app_src/views/questions.haml
badd +1 ~/Sites/InquireTi/app_src/controllers/questions.coffee
badd +1 ~/Sites/InquireTi/app/views/questions.xml
badd +1 \'/Users/smit1625/Sites/InquireTi/app_src/styles/questions.tss.coffee\'
badd +1 ~/Sites/InquireTi/app_src/styles/questions.tss.coffee
badd +1 ~/Sites/InquireTi/tiapp.xml
badd +1 ~/Sites/InquireTi/app/styles/questions.tss
badd +1 ~/Sites/InquireTi/app_src/views/account.haml
badd +1 ~/Sites/InquireTi/app/styles/app.tss
badd +1 \'/Users/smit1625/Sites/InquireTi/app_src/controllers/account.rb\'
badd +1 ~/Sites/InquireTi/app_src/controllers/account.coffee
badd +1 ~/Sites/InquireTi/app_src/controllers/home.coffee
badd +1 ~/Sites/InquireTi/app_src/views/home.haml
badd +1 ~/Sites/InquireTi/app_src/styles/home.tss.coffee
badd +1 ~/Sites/InquireTi/app_src/views/people.haml
badd +1 ~/Sites/InquireTi/app_src/controllers/people.coffee
badd +1 ~/Sites/InquireTi/app_src/styles/people.tss.coffee
badd +1 ~/Sites/InquireTi/\'
badd +1 ~/Sites/InquireTi/app_src/models/influencers.coffee
badd +1 ~/Sites/InquireTi/app_src/views/influencer.haml
badd +1 ~/Sites/InquireTi/app_src/controllers/influencer.coffee
badd +1 ~/Sites/InquireTi/app_src/views/answers.haml
badd +1 ~/Sites/InquireTi/app_src/controllers/answers.coffee
badd +1 ~/Sites/InquireTi/app_src/styles/influencer.tss.coffee
badd +1 ~/Sites/InquireTi/app_src/controllers/ask.coffee
badd +1 ~/Sites/InquireTi/app_src/views/ask.haml
badd +1 ~/Sites/InquireTi/app_src/styles/ask.tss.coffee
badd +1 ~/Sites/InquireTi/app_src/views/question.haml
badd +1 ~/Sites/InquireTi/app_src/views/login.haml
badd +1 ~/Sites/InquireTi/compile_config.yml
badd +1 ~/Sites/InquireTi/app_src/views/registration.haml
badd +1 ~/Sites/InquireTi/app_src/controllers/registration.coffee
badd +1 ~/Sites/InquireTi/app_src/styles/registration.tss.coffee
badd +1 ~/Sites/InquireTi/app_src/views/start.haml
badd +1 ~/Sites/InquireTi/app_src/controllers/start.coffee
badd +1 ~/Sites/InquireTi/\[Vundle]\ Installer
badd +1 ~/Sites/InquireTi/app_src/models/questions.coffee
badd +1 drillbit/tests/foo.js
badd +1 ~/Sites/InquireTi/app/controllers/influencer.js
badd +1 ~/Sites/InquireTi/app/controllers/people.js
badd +1 ~/Sites/InquireTi/app_src/models/influencer_categories.coffee
badd +1 ~/Sites/InquireTi/app_src/views/interests.haml
badd +1 ~/Sites/InquireTi/app_src/controllers/interests.coffee
badd +1 ~/Sites/InquireTi/app_src/controllers/explore.coffee
badd +1 ~/Sites/InquireTi/app_src/styles/interests.tss.coffee
badd +1 ~/Sites/InquireTi/app_src/views/explore.haml
badd +1 ~/Sites/InquireTi/app_src/controllers/popular.coffee
badd +1 ~/Sites/InquireTi/app/controllers/interests.js
badd +1 ~/Sites/InquireTi/app/controllers/explore.js
badd +1 ~/Sites/InquireTi/app_src/styles/explore.tss.coffee
badd +1 \'/Users/smit1625/Sites/InquireTi/app_src/views/popular.haml\'
badd +1 ~/Sites/InquireTi/app/controllers/app.js
badd +1 ~/Sites/InquireTi/app_src/views/popular.haml
badd +1 ~/Sites/InquireTi/app_src/views/interest.haml
badd +1 ~/Sites/InquireTi/app_src/styles/interest.tss.coffee
badd +1 ~/Sites/InquireTi/app_src/controllers/interest.coffee
badd +1 ~/Sites/InquireTi/app/README
badd +1 \'/Users/smit1625/Sites/InquireTi/app_src/lib/ui_components/content_switcher.coffee\'
badd +1 ~/Sites/InquireTi/app_src/lib/ui_components/content_switcher.coffee
badd +1 ~/Sites/InquireTi/app_src/lib/ui_components/control_bar.coffee
badd +1 ~/Sites/InquireTi/app_src/lib/ui_components/interests_grid.coffee
badd +1 ~/Sites/InquireTi/app_src/lib/view_helpers.coffee
badd +1 ~/Sites/InquireTi/app_src/lib/api_helpers.coffee
badd +1 ~/Sites/InquireTi/app_src/lib/user_auth.coffee
badd +1 ~/Sites/InquireTi/app_src/lib/ui_components/photo_header.coffee
badd +1 ~/Sites/InquireTi/app/lib/api_helpers.js
badd +1 ~/Sites/InquireTi/app_src/lib/ui_components/question_row.coffee
badd +1 ~/Sites/InquireTi/app_src/lib/ui_components/platinum_ui_component.coffee
badd +1 ~/Sites/InquireTi/app/lib/ui_components/platinum_ui_component.js
badd +1 ~/Sites/InquireTi/app_src/lib/ui_components/answerable_question_row.coffee
badd +281 ~/Sites/polygallery/test/dummy/spec/features/events_spec.rb
badd +6 ~/Sites/polygallery/app/controllers/concerns/polygallery/strong_params.rb
badd +33 ~/Sites/polygallery/test/dummy/app/controllers/events_controller.rb
badd +1 ~/Sites/polygallery/test/dummy/app/views/events/_form.html.haml
badd +1 ~/Sites/polygallery/test/dummy/app/views/events/_simple_form.html.haml
badd +1 ~/Sites/polygallery/lib/polygallery/view_helpers.rb
badd +1 ~/Sites/polygallery/app/views/polygallery/galleries/_simple_fields_for.html.haml
badd +1 ~/Sites/polygallery/app/views/polygallery/photos/_simple_fields_for.html.haml
badd +1 ~/Sites/polygallery/test/dummy/app/assets/javascripts/home.js
badd +1 ~/Sites/polygallery/test/dummy/app/assets/javascripts/events.js
badd +1 ~/Sites/polygallery/test/dummy/app/assets/javascripts/bootstrap.min.js
badd +1 ~/Sites/polygallery/test/dummy/app/assets/javascripts/application.js
badd +37 ~/Sites/polygallery/app/models/concerns/polygallery/acts_as_polyphoto.rb
badd +63 ~/Sites/polygallery/lib/polygallery/has_polygallery.rb
badd +1 ~/Sites/polygallery/spec/lib/has_polygallery_spec.rb
badd +34 ~/Sites/polygallery/test/dummy/spec/models/events_spec.rb
badd +27 ~/Sites/polygallery/test/dummy/spec/spec_helper.rb
badd +1 ~/Sites/polygallery/test/dummy/spec/factories/polygallery/photos.rb
badd +6 ~/Sites/polygallery/lib/polygallery/factories/polygallery/photos.rb
badd +34 ~/Sites/polygallery/test/dummy/spec/factories/events.rb
badd +1 ~/Sites/polygallery/spec/spec_helper.rb
badd +1 ~/Sites/polygallery/lib/polygallery/factories.rb
badd +2 ~/Sites/polygallery/lib/polygallery/factories/polygallery/galleries.rb
badd +57 ~/Sites/polygallery/lib/polygallery/capybara_helpers.rb
badd +1 ~/Sites/polygallery/app/models/polygallery/gallery.rb
badd +5 ~/Sites/polygallery/lib/polygallery/has_polyphotos.rb
badd +8 ~/Sites/polygallery/test/dummy/spec/models/polygallery/galleries_spec.rb
badd +1 ~/Sites/polygallery/test/dummy/spec/models/polygallery/photos_spec.rb
badd +1 ~/Sites/polygallery/test/dummy/app/models/event.rb
badd +3 ~/Sites/polygallery/lib/polygallery/version.rb
badd +19 ~/Sites/polygallery/Gemfile
badd +1 \'/Users/smit1625/Sites/polygallery/config/spring.rb\'
badd +1 ~/Sites/polygallery/config/spring.rb
badd +37 ~/Sites/polygallery/polygallery.gemspec
badd +4 ~/Sites/polygallery/config/routes.rb
badd +1 ~/Sites/polygallery/config/initializers/polygallery.rb
badd +8 ~/Sites/polygallery/lib/polygallery/railtie.rb
badd +5 ~/Sites/polygallery/lib/polygallery/glue.rb
badd +9 ~/Sites/polygallery/lib/polygallery/engine.rb
badd +6 ~/Sites/polygallery/db/migrate/20150701180557_create_polygalleries_if_necessary.rb
badd +7 ~/Sites/polygallery/lib/polygallery.rb
badd +12 ~/Sites/polygallery/lib/polygallery/paperclip_integration.rb
badd +172 lib/sesh/cli.rb
badd +18 lib/sesh/inferences.rb
badd +13 lib/sesh/assets/sample.yml
badd +74 lib/sesh/tmux_control.rb
badd +15 lib/sesh/ssh_control.rb
badd +1 lib/sesh.rb
badd +32 sesh.gemspec
badd +18 exe/return_to_sesh.applescript
badd +1 \'/Users/smit1625/Sites/sesh/exe/return_to_sesh.applescript\'
badd +2 exe/return_to_sesh
badd +3 exe/sesh
argglobal
silent! argdel *
edit lib/sesh/version.rb
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 15 + 31) / 62)
exe 'vert 1resize ' . ((&columns * 102 + 136) / 272)
exe '2resize ' . ((&lines * 14 + 31) / 62)
exe 'vert 2resize ' . ((&columns * 102 + 136) / 272)
exe '3resize ' . ((&lines * 14 + 31) / 62)
exe 'vert 3resize ' . ((&columns * 102 + 136) / 272)
exe '4resize ' . ((&lines * 22 + 31) / 62)
exe 'vert 4resize ' . ((&columns * 169 + 136) / 272)
exe '5resize ' . ((&lines * 22 + 31) / 62)
exe 'vert 5resize ' . ((&columns * 169 + 136) / 272)
exe '6resize ' . ((&lines * 14 + 31) / 62)
exe 'vert 6resize ' . ((&columns * 101 + 136) / 272)
exe '7resize ' . ((&lines * 14 + 31) / 62)
exe 'vert 7resize ' . ((&columns * 170 + 136) / 272)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
argglobal
edit exe/sesh
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 3 - ((1 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
3
normal! 015|
wincmd w
argglobal
edit lib/sesh/tmux_control.rb
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 192 - ((12 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
192
normal! 033|
wincmd w
argglobal
edit lib/sesh/ssh_control.rb
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 38 - ((1 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
38
normal! 036|
wincmd w
argglobal
edit lib/sesh/inferences.rb
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 41 - ((15 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
41
normal! 058|
wincmd w
argglobal
edit lib/sesh.rb
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 45 - ((6 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
45
normal! 031|
wincmd w
argglobal
edit lib/sesh/cli.rb
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 94 - ((13 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
94
normal! 032|
wincmd w
exe '1resize ' . ((&lines * 15 + 31) / 62)
exe 'vert 1resize ' . ((&columns * 102 + 136) / 272)
exe '2resize ' . ((&lines * 14 + 31) / 62)
exe 'vert 2resize ' . ((&columns * 102 + 136) / 272)
exe '3resize ' . ((&lines * 14 + 31) / 62)
exe 'vert 3resize ' . ((&columns * 102 + 136) / 272)
exe '4resize ' . ((&lines * 22 + 31) / 62)
exe 'vert 4resize ' . ((&columns * 169 + 136) / 272)
exe '5resize ' . ((&lines * 22 + 31) / 62)
exe 'vert 5resize ' . ((&columns * 169 + 136) / 272)
exe '6resize ' . ((&lines * 14 + 31) / 62)
exe 'vert 6resize ' . ((&columns * 101 + 136) / 272)
exe '7resize ' . ((&lines * 14 + 31) / 62)
exe 'vert 7resize ' . ((&columns * 170 + 136) / 272)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOc
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
let g:this_obsession = v:this_session
unlet SessionLoad
" vim: set ft=vim :
