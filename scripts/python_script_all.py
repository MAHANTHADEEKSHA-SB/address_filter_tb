#!/usr/bin/python

import subprocess 
import os
call = subprocess

li = []
li = os.listdir("../test/")
res = []
for i in li:
   if i == "base_test.sv":
      continue
   
   elif (i[len(i)-9 : len(i)-5] == "test") or (i[len(i)-7 : len(i)] == "test.sv"):
      res.append(i[0 :len(i)-3])


call = subprocess

for i in res:
   res_test = "TEST="
   res_test = res_test + i
   print("------------------------------------------------------------------------------")
   print("------------------------------------------------------------------------------")
   print("EXECUTING TEST : "+res_test[5:len(res_test)])
   print("------------------------------------------------------------------------------")
   print("------------------------------------------------------------------------------")
   print("                          ")
   call.call(["make","all",res_test,"GUI=0"])
   print("------------------------------------------------------------------------------")
   print("------------------------------------------------------------------------------")

'''cov_li = []
cov_li = os.listdir("../coverage/")
cov_li_res = []

for i in cov_li:
   if(i[len(i)-5 : len(i)] == ".ucdb"):
      cov_li_res.append(i)

res =["vcover","merge"]
cov_path="/home/mahanthab/projects/apb_uvc_layer/coverage/"
for i in range(len(cov_li_res)):
      temp =""
      temp = cov_path + cov_li_res[i]
      res.append(temp)
call.call(res)     
'''

