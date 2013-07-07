
class Dashing.Graph extends Dashing.Widget

  @accessor 'current', ->
    return @get('displayedValue') if @get('displayedValue')
    points = @get('points')
    if points
      points[points.length - 1].y[0]

  ready: ->
    container = $(@node).parent()
    # Gross hacks. Let's fix this.
    width = (Dashing.widget_base_dimensions[0] * container.data("sizex")) + Dashing.widget_margins[0] * 2 * (container.data("sizex") - 1)
    height = (Dashing.widget_base_dimensions[1] * container.data("sizey"))
    numseries = $(@node).data('series') || 1;
    colors = [ 'steelblue', 'lightblue' ]
    series = [ { data: [ { x: 0, y: 0 } ], color: colors[0] } ]

    refresh = (idx,series) ->
      if points
        data = points.map (p) -> { y: p.y[idx], x: p.x }
      else
        data = [ { x: 0, y: 0 } ]
      series[idx] = { data: data, color: colors[idx] }

    points = @get('points') 
    refresh idx,series for idx in [0..numseries-1]

    @graph = new Rickshaw.Graph(
      element: @node
      width: width
      height: height
      stroke: true
      #renderer: 'area'
      series: series
    )
 
    @graph.renderer.unstack = true;

    x_axis = new Rickshaw.Graph.Axis.Time(graph: @graph)
    y_axis = new Rickshaw.Graph.Axis.Y(graph: @graph, tickFormat: Rickshaw.Fixtures.Number.formatKMBT)
    @graph.render()

  onData: (data) ->
    
    refresh = (idx,series) -> 
      d = data.points.map (p) -> { y: p.y[idx], x: p.x }
      series[idx].data = d
      
    len = @graph.series.length

    if @graph
      refresh idx,@graph.series for idx in [0..len-1]

      @graph.render()
