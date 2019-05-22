# coding: utf-8

puts 'Seeding the database...'

Country.create(name: 'Australia', name_en: 'Australia')
Country.create(name: 'China', name_en: 'China')
state = State.create(name: 'West Australian', acronym: 'WA')
City.create(name: 'Perth', state_id: state.id)

[
  { pt: 'Art', en: 'Art', fr: 'Art'},
  { pt: 'Visual Arts', en: 'Visual Arts', fr: 'Art plastique' },
  { pt: 'Circus', en: 'Circus', fr: 'Cirque' },
  { pt: 'Community', en: 'Community', fr: 'Comunauté' },
  { pt: 'Humor', en: 'Humor', fr: 'Humour' },
  { pt: 'Comicbooks', en: 'Comicbooks', fr: 'bd' },
  { pt: 'Dance', en: 'Dance', fr: 'Dance' },
  { pt: 'Design', en: 'Design', fr: 'Design' },
  { pt: 'Events', en: 'Events', fr: 'Événementiel' },
  { pt: 'Fashion', en: 'Fashion', fr: 'Mode' },
  { pt: 'Gastronomy', en: 'Gastronomy', fr: 'Gastronomie' },
  { pt: 'Film & Video', en: 'Film & Video', fr: 'Cinéma' },
  { pt: 'Games', en: 'Games', fr: 'Jeux' },
  { pt: 'Journalism', en: 'Journalism', fr: 'Journalisme' },
  { pt: 'Music', en: 'Music', fr: 'Musique' },
  { pt: 'Photography', en: 'Photography', fr: 'Photographie' },
  { pt: 'Science & Technology', en: 'Science & Technology', fr: 'Sciences et technologies' },
  { pt: 'Theatre', en: 'Theatre', fr: 'Théatre' },
  { pt: 'Sport', en: 'Sport', fr: 'Sport' },
  { pt: 'Web', en: 'Web', fr: 'Web' },
  { pt: 'Carnival', en: 'Carnival', fr: 'Carnaval' },
  { pt: 'Architecture & Urbanism', en: 'Architecture & Urbanism', fr: 'Architecture et Urbanisme' },
  { pt: 'Literature', en: 'Literature', fr: 'Literature' },
  { pt: 'Mobility & Transportation', en: 'Mobility & Transportation', fr: 'Transport et Mobilité' },
  { pt: 'Environment', en: 'Environment', fr: 'Environement' },
  { pt: 'Social Business', en: 'Social Business', fr: 'Social' },
  { pt: 'Education', en: 'Education', fr: 'Éducation' },
  { pt: 'Fiction Films', en: 'Fiction Films' , fr: 'Films de fiction'},
  { pt: 'Documentary Films', en: 'Documentary Films', fr: 'Films documentaire' },
  { pt: 'Experimental Films', en: 'Experimental Films' },
  { pt: 'Health', en: 'Health', fr: 'Santé' }
].each do |name|
   category = Category.find_or_initialize_by(name_pt: name[:pt])
   category.update_attributes({
     name_en: name[:en]
   })
   category.update_attributes({
     name_fr: name[:fr]
   })
 end


{
  company_name: 'Catarse',
  company_logo: 'http://catarse.me/assets/catarse_bootstrap/logo_icon_catarse.png',
  host: 'catarse.me',
  base_url: "http://catarse.me",

  email_contact: 'contato@catarse.me',
  email_payments: 'financeiro@catarse.me',
  email_projects: 'projetos@catarse.me',
  email_system: 'system@catarse.me',
  email_no_reply: 'no-reply@catarse.me',
  facebook_url: "http://facebook.com/catarse.me",
  facebook_app_id: '173747042661491',
  twitter_url: 'http://twitter.com/catarse',
  twitter_username: "catarse",
  mailchimp_url: "http://catarse.us5.list-manage.com/subscribe/post?u=ebfcd0d16dbb0001a0bea3639&amp;id=149c39709e",
  catarse_fee: '0.13',
  support_forum: 'http://suporte.catarse.me/',
  base_domain: 'catarse.me',
  uservoice_secret_gadget: 'change_this',
  uservoice_key: 'uservoice_key',
  faq_url: 'http://suporte.catarse.me/',
  feedback_url: 'http://suporte.catarse.me/forums/103171-catarse-ideias-gerais',
  terms_url: 'http://suporte.catarse.me/knowledgebase/articles/161100-termos-de-uso',
  privacy_url: 'http://suporte.catarse.me/knowledgebase/articles/161103-pol%C3%ADtica-de-privacidade',
  about_channel_url: 'http://blog.catarse.me/conheca-os-canais-do-catarse/',
  instagram_url: 'http://instagram.com/catarse_',
  blog_url: "http://blog.catarse.me",
  github_url: 'http://github.com/catarse',
  contato_url: 'http://suporte.catarse.me/'
}.each do |name, value|
   conf = CatarseSettings.find_or_initialize_by(name: name)
   conf.update_attributes({
     value: value
   }) if conf.new_record?
end

OauthProvider.find_or_create_by!(name: 'facebook') do |o|
  o.key = 'your_facebook_app_key'
  o.secret = 'your_facebook_app_secret'
  o.path = 'facebook'
end

puts
puts '============================================='
puts ' Showing all Authentication Providers'
puts '---------------------------------------------'

OauthProvider.all.each do |conf|
  a = conf.attributes
  puts "  name #{a['name']}"
  puts "     key: #{a['key']}"
  puts "     secret: #{a['secret']}"
  puts "     path: #{a['path']}"
  puts
end


puts
puts '============================================='
puts ' Showing all entries in Configuration Table...'
puts '---------------------------------------------'

CatarseSettings.all.each do |conf|
  a = conf.attributes
  puts "  #{a['name']}: #{a['value']}"
end

Rails.cache.clear

puts '---------------------------------------------'
puts 'Done!'
