module "Guides"

jsondata= [
  {x: 2, y: 1},
  {x: 3, y: 3}
]
data = polyjs.debug.data (data: jsondata)
sampleLayer = {data: data, type: 'point', x: 'x', y: 'y'}

test "domain: strict mode num & cat", ->
  spec =
    render: false
    layers: [ sampleLayer ]
    strict: true
    guides:
      x: { type: 'num', min: 0, max: 9, bw : 3 }
      y: { type: 'cat', levels: [1,2,3], labels: {1: 'One', 2: 'Five'} }
  graph = polyjs.debug.chart spec
  domains = graph.facet.panes[""].domains
  equal domains.x.type, 'num'
  equal domains.x.min , 0
  equal domains.x.max, 9
  equal domains.x.bw, 3
  equal domains.y.type, 'cat'
  deepEqual domains.y.levels, [1,2,3]
  equal domains.y.sorted, false

  xticks = graph.scaleSet.axes.axes.x.ticks
  yticks = graph.scaleSet.axes.axes.y.ticks
  deepEqual _.pluck(xticks, 'location'), [0, 3, 6, 9]
  deepEqual _.pluck(yticks, 'location'), [3, 1, 2]
  deepEqual _.pluck(yticks, 'value'), [3, 'One', 'Five']

test "scale: x and v:", ->
  spec =
    render: false
    layers: [ sampleLayer ]
    strict: true
    guides:
      x: { type: 'num', min: 2, max: 4, bw : 3 }
      y: { type: 'num', min: 1, max: 3 }
  graph = polyjs.debug.chart spec
  domains = graph.facet.panes[""].domains

  equal domains.x.type, 'num'
  equal domains.x.min , 2
  equal domains.x.max, 4
  equal domains.x.bw, 3
  equal domains.y.type, 'num'
  equal domains.y.min , 1
  equal domains.y.max, 3

###
  equal scales.x(2), 0+30
  equal scales.x(3), 150+30
  equal scales.x(4), 300+30
  equal scales.y(3), 0+20
  equal scales.y(2), 150+20
  equal scales.y(1), 300+20
###
  #deepEqual layers[0].geoms, 0

