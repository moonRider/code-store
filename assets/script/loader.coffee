class Loader
  @sources_map: {}
  @sources: {}

  @regist: (name, fetch_path)->
    if (name is undefined) or (fetch_path is undefined)
      throw new ReferenceError('source name or source path has not be specified')
    else
      @constructor.sources_map[name] = fetch_path
      @constructor.sources[name] = localStorage.getItem("loader_#{name}") or undefined

  @unRegist: (name)->
    delete @constructor.sources_map[name]
    delete @constructor.sources[name]

  @clear: ->
    @sources_map = {}
    @sources = {}

  @removeSoure: (name)->
    delete @constructor.sources[name]

  @store: (name)->
    localStorage.setItem "loader_#{name}", JSON.stringify(@constructor.sources[name])

  @unStore: (name)->
    localStorage.removeItem "loader_#{name}"

  defaultOptions:
    cache: true
    ready: ->

  fetcher: (url)->
    if $? and $.getJSON
      xhr = $.getJSON url

  constructor: (fetcher)->
    @fetcher = fetcher

  load: (sources, options)->
    options = Object.assign {}, @defaultOptions, options
    completed_count = 0

    sources.forEach (source)->
      if options.cache and @constructor.sources[source]?
        completed_count += 1
      else
        try
          @fetcher(@constructor.sources_map[source])
            .done (data, status, xhr)=>
              @constructor.sources[source] = data
            .complete (xhr, status)=>
              completed_count += 1
              if completed_count is sources.length
                options.ready()
        catch error
          console.log error
          throw new Error('fetcher is invalid')

@Loader = Loader