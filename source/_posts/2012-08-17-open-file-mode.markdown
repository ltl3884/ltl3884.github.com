---
layout: post
title: "open-file-mode"
date: 2012-08-17 10:33:04 +0800
comments: true
categories: ruby
---

## r

    Read-only mode. The file pointer is placed at the beginning of the file. 
    This is the default mode.

## r+

    Read-write mode. The file pointer will be at the beginning of the file.

## w

    Write-only mode. Overwrites the file if the file exists. 
    If the file does not exist, creates a new file for writing.

## w+

    Read-write mode. Overwrites the existing file if the file exists. 
    If the file does not exist, creates a new file for reading and writing.

## a

    Write-only mode. 
    The file pointer is at the end of the file if the file exists. 
    That is, the file is in the append mode. 
    If the file does not exist, it creates a new file for writing.

## a+

    Read and write mode. 
    The file pointer is at the end of the file if the file exists. 
    The file opens in the append mode. 
    If the file does not exist, it creates a new file for reading and writing.
