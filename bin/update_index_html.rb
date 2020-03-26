content = File.read('docs/index_content.html')

content = <<-EOF
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>CovidAPI - Daily COVID-19 statistics by country, region, and city</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
    body {
      margin: 30px 0;
    }
    h1 {
      margin-bottom: 20px;
    }
    pre {
      background-color: #f9f9f9;
      padding: 14px;
    }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="row">
        <div class="col-md-12">
#{content}
        </div>
      </div>
    </div>
  </body>
</html>
EOF

File.write('docs/index.html', content)
