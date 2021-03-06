# -*- coding: utf-8 -*-
ws = new WebSocket "ws://#{window.location["host"]}/exchange/USDJPY"
count = 50
recieved = 0
flag = null
stop = null
chart = null
data = []

google.load 'visualization', '1',
  packages: ['corechart']
google.setOnLoadCallback () ->
  chart = new google.visualization.CandlestickChart document.getElementById 'holder'
  google.visualization.events.addListener chart, 'onmouseover', () ->
    stop = true
  google.visualization.events.addListener chart, 'onmouseout', () ->
    stop = false
  drawVisualization [["loading...",50,50,50,50]], 'out'
  return

drawVisualization = (raws, hAxis_textPosition) ->
  # Populate the data table.
  dataTable = google.visualization.arrayToDataTable raws, true
  # Draw the chart.
  chart.draw dataTable,
    title: "USD/JPY"
    legend: 'none'
    hAxis:
      textPosition: hAxis_textPosition ? 'none'
  return

setInterval () ->
  if not stop and data.length >= count
    drawVisualization data[0...count]
    data.shift()
    flag = false
  else
    flag = true
, 300

$ () ->
  ws.onopen = () ->
    return
  ws.onmessage = (e) ->
    d = Util.parse(e)
    Util.stream(d)
    recieved += 1
    if e.data and flag
      line = e.data
      if line.charAt(0) == "1"
        rows = line.split(",")[..4]
        rows[0] = (new Date(parseInt(rows[0]) * 1000)).toString()
        for i ,index in rows[1..4]
          rows[index+1] = parseFloat i
        data.push rows
    return
  return
