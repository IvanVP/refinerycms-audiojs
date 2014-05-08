# Refinery CMS Audiojs

Simple audio extension for [Refinery CMS](http://refinerycms.com).
It adds a 'Audios' tab to Admin menu where You can manage audios.
Adds also an 'Add audio' link to WYMeditor on 'Pages'.

There are 2 ways to include audios in your project.
- You can upload files
- You can use link to external source

Audio (instance of `Refinery::Audios::Audio` model) uses one file in MP3 format and plays it using [Audiojs player](http://kolber.github.io/audiojs/) from [here](https://github.com/kolber/audiojs). Thanks Kolber!.


The instance method `Audio#audio_to_html` renders an html audio tag like:

```html
<audio id="audio_1" preload="auto">
  <source src="musicfile.mp3" type="audio/mpeg">
</audio>
```
You can change autoplay and loop attributes.

The instance method `Audio#audio_to_html(true)` adds `controls` attribute to see audiofile properly in WYM editor.

```html
<audio id="audio_1" preload="auto" controls="controls">
  <source src="musicfile.mp3" type="audio/mpeg">
</audio>
```

And then JS in `audio_init.js` removes `controls` attribute and initilizes Audiojs player. In `audio.js` You can change CSS-styles, for example width of player.


This content can be added to a page in WYMeditor, or everywhere in your view like. Don't forget include audio_init.js in Your `application.js` file - it clears `controls` attribute.

```erb
  <%= @my_audio.audio_to_html(true) %>
```

This extension: 
  * Uses the [Audiojs player](http://kolber.github.io/audiojs/) to playback audio (except embedded audio, of course).
  * Allows you to manage playback configuration (preload, autoplay, loop attributes).
  * Allows you to insert audio to pages using WYMeditor, by inserting an HTML code with audio tag.
  * Automatically uses audio.js library on your website frontend(must be included in Your application.js file.

## Requirements
Refinery CMS version 2.0.1 or above

## Install
Open up your ``Gemfile`` and add at the bottom this line:

```ruby
gem 'refinerycms-audiojs', github: 'IvanVP/refinerycms-audiojs'
```

Now, run: 

    bundle install
    rails generate refinery:audios
    rake db:migrate


## Adding whitelist tags
Add whitelist_tags in Your app config/initializers/refinery/core.rb

```ruby
config.wymeditor_whitelist_tags = {'audio' => {'attributes' => {'1' => 'preload', '2' => 'autoplay', '3' => 'loop', '4' => 'controls', '5' => 'source'} }, 'source' => {'attributes' => {'1' => 'src', '2' => 'type'}}}
```

If You want to see audio tag in Page/Preview mode (inside WYM editor dialog ) add in config/application.rb

```ruby
config.action_view.sanitized_allowed_tags = %w( audio source )
config.action_view.sanitized_allowed_attributes = %w( preview autoload loop controls src type )
```

If You still have some problems, try delete cache files in tmp/cache/assets directory.

## I18N

Only 'en' and 'ru' locales available. 

To add locale ('en' or 'ru') just copy from source file from GitHub lines to existing `en.yml`

When adding new locale please add in Line4 app/assets/javascripts/refinery/admin/wymeditor_monkeypatch1.js.erb Your locale

```ruby
<% locales = %w(en ru)%>
```
And then create and translate locale file.

## Last step

Check in Your application.js 

```ruby
//= require audio
//= require audiojs_init
```

and `player-graphics.gif` in assets/images/


And you're done.

No tests yet, sorry.

## More Information
- Check out Refinery CMS [guides](http://refinerycms.com/guides)

