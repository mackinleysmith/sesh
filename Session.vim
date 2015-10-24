let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Sites/sesh
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +5 ~/Sites/teacher-impact/app/views/teachers/_profile.html.haml
badd +87 ~/Sites/energy-innovation-award/config/database.yml
badd +15 ~/Sites/teacher-impact/config/initializers/devise.rb
badd +15 ~/Sites/teacher-impact/config/secrets.yml
badd +9 ~/Sites/teacher-impact/app/views/admin/users/index.html.haml
badd +10 ~/Sites/teacher-impact/app/views/admin/users/_table.html.haml
badd +21 ~/Sites/teacher-impact/app/views/admin/users/_table_row.html.haml
badd +1 ~/Sites/teacher-impact/app/views/admin/users/_details_cell.html.haml
badd +1 ~/Sites/teacher-impact/app/views/admin/students/_details_cell.html.haml
badd +21 ~/Sites/teacher-impact/app/models/user.rb
badd +43 ~/Sites/teacher-impact/app/helpers/user_profiles_helper.rb
badd +10 ~/Sites/teacher-impact/app/views/admin/teachers/_table_row.html.haml
badd +6 ~/Sites/teacher-impact/app/views/admin/teachers/_details_cell.html.haml
badd +6 ~/Sites/teacher-impact/app/views/admin/student_parents/_details_cell.html.haml
badd +151 ~/Sites/teacher-impact/app/assets/stylesheets/bootstrap-overrides.scss
badd +6 ~/Sites/teacher-impact/app/models/concerns/user_profile.rb
badd +16 ~/Sites/teacher-impact/app/models/profile_view.rb
badd +14 ~/Sites/teacher-impact/app/helpers/application_helper.rb
badd +50 ~/Sites/teacher-impact/app/models/ability.rb
badd +1 ~/Sites/teacher-impact/app/views/admin/students/_table_row.html.haml
badd +13 ~/Sites/teacher-impact/app/views/admin/student_parents/_table_row.html.haml
badd +9 ~/Sites/teacher-impact/app/controllers/application_controller.rb
badd +1 ~/Sites/polyblock/app/assets/javascripts/polyblock/polyblock.js.coffee
badd +25 ~/Sites/the-riverboat/app/assets/javascripts/admin/users.js.coffee
badd +1 ~/Sites/the-riverboat/app/views/events/index.html.haml
badd +1 ~/Sites/teacher-impact/app/views/layouts/application.html.haml
badd +74 ~/Sites/teacher-impact/app/views/main/home.html.haml
badd +16 ~/Sites/teacher-impact/\[Vundle]\ Installer
badd +828 /private/var/folders/2s/84cdz1jx6w181h6gyy_mb9dr0000gp/T/nvimg5wUrP/1
badd +1 ~/Sites/teacher-impact/app/views/shared/_main_nav.html.haml
badd +6 ~/Sites/teacher-impact/app/views/shared/_footer.html.haml
badd +5 ~/Sites/teacher-impact/app/views/shared/_social_icons.html.haml
badd +54 ~/Sites/teacher-impact/config/environments/development.rb
badd +1 ~/Sites/teacher-impact/app/views/shared/_flash_messages.html.haml
badd +26 ~/Sites/teacher-impact/spec/features/users_spec.rb
badd +7 ~/Sites/teacher-impact/spec/features/students_spec.rb
badd +12 ~/Sites/teacher-impact/app/views/devise/invitations/edit.html.haml
badd +23 ~/Sites/teacher-impact/config/locales/en.yml
badd +10 ~/Sites/teacher-impact/config/locales/devise.en.yml
badd +5 ~/Sites/teacher-impact/config/locales/devise_invitable.en.yml
badd +18 ~/Sites/teacher-impact/app/controllers/teacher_profiles_controller.rb
badd +8 ~/Sites/teacher-impact/app/views/teacher_profiles/_form.html.haml
badd +12 ~/Sites/teacher-impact/app/views/student_profiles/_form.html.haml
badd +2 ~/Sites/teacher-impact/app/models/student_profile.rb
badd +1 ~/Sites/teacher-impact/app/models/teacher_profile.rb
badd +1 ~/Sites/teacher-impact/app/views/teacher_profiles/_teacher_employment_fields.html.haml
badd +22 ~/Sites/teacher-impact/app/controllers/concerns/teacher_profile_fetching.rb
badd +3 ~/Sites/teacher-impact/app/controllers/teachers_controller.rb
badd +1 ~/Sites/teacher-impact/app/views/teachers/show.html.haml
badd +4 ~/Sites/teacher-impact/app/controllers/main_controller.rb
badd +1 ~/Sites/teacher-impact/app/models/teacher.rb
badd +19 ~/Sites/the-riverboat/app/views/admin/events/index.html.haml
badd +3 ~/Sites/teacher-impact/app/controllers/registrations_controller.rb
badd +5 ~/Sites/zip_search/lib/zip_search/acts_as_location.rb
badd +15 ~/.ssh/config
badd +13 ~/Sites/zip_search/zip_search.gemspec
badd +1 ~/Sites/zip_search/app/models/zip_search/zip_search.rb
badd +1 ~/Sites/zip_search/app/models/zip_search/location.rb
badd +8 ~/Sites/zip_search/lib/zip_search.rb
badd +7 ~/Sites/zip_search/lib/zip_search/engine.rb
badd +1 ~/Sites/zip_search/lib/zip_search/railtie.rb
badd +4 ~/Sites/zip_search/lib/zip_search/model_helpers.rb
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
badd +1 lib/sesh/version.rb
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
badd +47 lib/sesh/tmux_control.rb
badd +15 lib/sesh/ssh_control.rb
badd +1 lib/sesh.rb
badd +32 sesh.gemspec
badd +18 exe/return_to_sesh.applescript
badd +1 \'/Users/smit1625/Sites/sesh/exe/return_to_sesh.applescript\'
badd +1 exe/return_to_sesh
badd +3 exe/sesh
badd +4 Gemfile
badd +1 ~/Sites/teacher-impact/app/assets/stylesheets/bootstrap-variables.scss
badd +1 ~/Sites/teacher-impact/app/models/teacher_employment.rb
badd +1 ~/Sites/teacher-impact/app/models/school_attendance.rb
badd +1 \'/Users/mackinleysmith/Sites/teacher-impact/app/views/teacher_profiles/_awards_and_recognitions.html.haml\'
badd +1 ~/Sites/teacher-impact/app/views/teacher_profiles/_awards_and_recognitions.html.haml
badd +1 ~/Sites/teacher-impact/app/views/teacher_profiles/_comments.html.haml
badd +1 ~/Sites/teacher-impact/app/views/teacher_profiles/_employment_history_form.html.haml
badd +6 ~/Sites/teacher-impact/config/routes.rb
badd +1 ~/Sites/teacher-impact/app/views/teacher_profiles/employment_history.html.haml
badd +1 ~/Sites/teacher-impact/config/initializers/simple_form_bootstrap.rb
badd +1 ~/Sites/teacher-impact/app/views/schools/_nested_fields.html.haml
badd +85 ~/Sites/teacher-impact/Gemfile
badd +1 ~/Sites/teacher-impact/app/models/school.rb
badd +1 ~/Sites/teacher-impact/app/controllers/schools_controller.rb
badd +1 ~/Sites/teacher-impact/app/assets/javascripts/schools.coffee
badd +1 ~/Sites/teacher-impact/app/views/student_profiles/_school_attendance_fields.html.haml
badd +1 ~/Sites/teacher-impact/db/schema.rb
badd +4 ~/Sites/teacher-impact/app/views/teacher_profiles/_currently_teaching.html.haml
badd +1 ~/Sites/teacher-impact/app/views/teacher_profiles/_employment_history.html.haml
badd +1 ~/Sites/teacher-impact/app/views/teacher_profiles/_career_background.html.haml
badd +1 ~/Sites/teacher-impact/app/views/teacher_profiles/_instructional_skills.html.haml
badd +1 ~/Sites/teacher-impact/app/views/teacher_profiles/_teaching_philosophy.html.haml
badd +21 ~/Sites/teacher-impact/app/views/schools/show.html.haml
badd +1 ~/Sites/teacher-impact/app/views/students/_profile.html.haml
badd +1 ~/Sites/teacher-impact/app/views/students/show.html.haml
badd +1 ~/Sites/teacher-impact/app/views/student_profiles/_schools_attended.html.haml
badd +1 ~/Sites/teacher-impact/app/views/student_profiles/_currently_attending.html.haml
badd +1 ~/Sites/teacher-impact/app/controllers/student_parents_controller.rb
badd +1 ~/Sites/teacher-impact/app/views/student_parents/show.html.haml
badd +1 ~/Sites/teacher-impact/app/controllers/student_parent_profiles_controller.rb
badd +1 ~/Sites/teacher-impact/app/controllers/concerns/student_parent_profile_fetching.rb
badd +12 ~/Sites/teacher-impact/app/views/student_parents/_profile.html.haml
badd +2 ~/Sites/teacher-impact/app/views/main/search.html.haml
badd +1 ~/Sites/teacher-impact/db/migrate/20151005205719_create_instructional_skills.rb
badd +1 ~/Sites/teacher-impact/app/controllers/concerns/student_profile_fetching.rb
badd +1 ~/Sites/teacher-impact/db/migrate/20151005211627_create_teacher_skills.rb
badd +1 ~/Sites/teacher-impact/app/models/teacher_skill.rb
badd +1 ~/Sites/teacher-impact/app/models/instructional_skill.rb
badd +1 ~/Sites/teacher-impact/db/migrate/20151005212541_create_endorsements.rb
badd +7 ~/Sites/teacher-impact/app/views/student_parent_profiles/_form.html.haml
badd +1 ~/Sites/teacher-impact/app/views/schools/_search_result.html.haml
badd +1 ~/Sites/teacher-impact/app/views/users/_search_result.html.haml
badd +1 ~/Sites/teacher-impact/app/views/users/_role_indicator.html.haml
badd +1 ~/Sites/teacher-impact/app/views/users/_avatar.html.haml
badd +1 ~/Sites/teacher-impact/app/views/schools/_avatar.html.haml
badd +1 ~/Sites/teacher-impact/app/views/schools/_role_indicator.html.haml
badd +1 ~/Sites/teacher-impact/app/views/admin/schools/_table_row.html.haml
badd +1 ~/Sites/teacher-impact/app/views/admin/schools/_details_cell.html.haml
badd +1 ~/Sites/teacher-impact/app/assets/javascripts/bootstrap-tagsinput.js
badd +1 ~/Sites/teacher-impact/app/assets/javascripts/application.js
badd +1 ~/Sites/teacher-impact/app/assets/javascripts/teacher_profiles.coffee
badd +15 ~/Sites/teacher-impact/app/models/endorsement.rb
badd +1 ~/Sites/teacher-impact/app/controllers/admin/users_controller.rb
badd +1 ~/Sites/teacher-impact/app/controllers/user_profiles_controller.rb
badd +17 ~/Sites/teacher-impact/spec/models/user_spec.rb
badd +1 ~/Sites/teacher-impact/app/views/devise/registrations/new.html.haml
badd +1 ~/Sites/teacher-impact/app/views/devise/registrations/edit.html.haml
badd +19 ~/Sites/teacher-impact/app/views/admin/base/analytics.html.haml
badd +28 ~/Sites/teacher-impact/app/controllers/admin/charts_controller.rb
badd +27 \[Vundle]\ Installer
badd +23 /private/var/folders/2s/84cdz1jx6w181h6gyy_mb9dr0000gp/T/nvim9QEUgO/1
badd +23 /var/folders/2s/84cdz1jx6w181h6gyy_mb9dr0000gp/T/nvim9QEUgO/1
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
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 20 + 31) / 62)
exe 'vert 1resize ' . ((&columns * 136 + 136) / 272)
exe '2resize ' . ((&lines * 18 + 31) / 62)
exe 'vert 2resize ' . ((&columns * 136 + 136) / 272)
exe '3resize ' . ((&lines * 20 + 31) / 62)
exe 'vert 3resize ' . ((&columns * 135 + 136) / 272)
exe '4resize ' . ((&lines * 18 + 31) / 62)
exe 'vert 4resize ' . ((&columns * 135 + 136) / 272)
exe '5resize ' . ((&lines * 20 + 31) / 62)
exe 'vert 5resize ' . ((&columns * 137 + 136) / 272)
exe '6resize ' . ((&lines * 20 + 31) / 62)
exe 'vert 6resize ' . ((&columns * 53 + 136) / 272)
exe '7resize ' . ((&lines * 20 + 31) / 62)
exe 'vert 7resize ' . ((&columns * 80 + 136) / 272)
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
let s:l = 2 - ((1 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
2
normal! 019|
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
let s:l = 42 - ((7 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
42
normal! 049|
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
let s:l = 38 - ((0 * winheight(0) + 10) / 20)
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
let s:l = 36 - ((35 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
36
normal! 025|
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
let s:l = 39 - ((7 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
39
normal! 023|
wincmd w
argglobal
edit sesh.gemspec
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 23 - ((3 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
23
normal! 0
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
let s:l = 246 - ((0 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
246
normal! 019|
wincmd w
exe '1resize ' . ((&lines * 20 + 31) / 62)
exe 'vert 1resize ' . ((&columns * 136 + 136) / 272)
exe '2resize ' . ((&lines * 18 + 31) / 62)
exe 'vert 2resize ' . ((&columns * 136 + 136) / 272)
exe '3resize ' . ((&lines * 20 + 31) / 62)
exe 'vert 3resize ' . ((&columns * 135 + 136) / 272)
exe '4resize ' . ((&lines * 18 + 31) / 62)
exe 'vert 4resize ' . ((&columns * 135 + 136) / 272)
exe '5resize ' . ((&lines * 20 + 31) / 62)
exe 'vert 5resize ' . ((&columns * 137 + 136) / 272)
exe '6resize ' . ((&lines * 20 + 31) / 62)
exe 'vert 6resize ' . ((&columns * 53 + 136) / 272)
exe '7resize ' . ((&lines * 20 + 31) / 62)
exe 'vert 7resize ' . ((&columns * 80 + 136) / 272)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOc
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
let g:this_session = v:this_session
let g:this_obsession = v:this_session
let g:this_obsession_status = 2
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
