<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
   
    <style>
        .modal-content{
            border: 1px solid;
            margin-top: 150px;
            position: fixed;
            left: 40%;
            padding: 20px;
            height: 380px;
            width: 300px;
            display: none;
            z-index: 1;
            background-color: white;
        }

        .form-group{
            padding: 5px;

        }
        .modal-header{
            display: flex;
            justify-content: center;
        }
        #profile{
            
            border: 1px solid;
            height: 110px;
            width: 100px;
        }
        .modal-close {
            float: right;
        }
        .modal-close:hover{
            color:red;
        }
        .form-group{
            margin:auto; 
        }

       .find, .modal-footer{
            text-align: center;
        }
        
        .black-bg{
        display: none;
        position: absolute;
        content: "";
        width: 100%;
        height: 100%;
        background-color:rgba(0, 0,0, 0.5);
        top:0;
        left: 0;
        z-index: 1;
    }

    #googlelogo{
        width: 40px;
        height: 40px;
        
    }
    .saveId{
    	text-align: left;
    	margin: 0;
    }
    

    </style>
</head>