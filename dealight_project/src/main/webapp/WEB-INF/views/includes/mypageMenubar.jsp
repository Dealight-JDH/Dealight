<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <!-- 현수현수현수 -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
    .mydropbtn {
  background-color: #4CAF50;
  color: white;
  padding: 16px;
  font-size: 16px;
  border: none;
}

.mydropdown {
  position: relative;
  display: inline-block;
}

.mydropdown-content {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.mydropdown-content a {
  color: black;
  font-size: 5px;
  padding: 3px 5px;
  text-decoration: none;
  display: block;
}

 .mydropdown-content a:hover {background-color: #ddd;}

.mydropdown:hover .dropdown-content {display: block;}

.mydropdown:hover .dropbtn {background-color: #3e8e41;} 
</style>

</head>