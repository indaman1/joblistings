<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>mail</title>
</head>
<body>
    <h1>{{ $job->title }}</h1>
    <h2>Congratulations your job is now live on our website.</h2>
    <p>
        <a href="{{ url('/jobs/' . $job->id) }}">View your Job listing</a>
    </p>
   