make:
	ldc2 coldfear_retail.d
	del coldfear_retail.obj
	upx -9 coldfear_retail.exe
