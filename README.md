# FastAfnTool
Second package the afnetworking, more simple to use with get request and post request. 
二次封装了AFN网络请求工具, 使其变得更加简单易用.
* 如果你觉得不错，还请为我star一个，
* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢

##用法:
get请求类方法
+ (void)getWithURL: (NSString *)URLStr cookie: (NSString *)cookie success: (SUCCESS_BLOCK)successBlock failure: (FAILURE_BLOCK)failureBlock;
带字典参数的post请求类方法
+ (void)postWithURL: (NSString *)URLStr parameters: (id)parameters cookie: (NSString *)cookie success: (SUCCESS_BLOCK)successBlock failure: (FAILURE_BLOCK)failureBlock;
带字符串参数的post请求类方法
+ (void)postWithURL: (NSString *)URLStr bodyStr: (NSString *)bodyStr cookie: (NSString *)cookie success: (SUCCESS_BLOCK)successBlock failure: (FAILURE_BLOCK)failureBlock;
带缓存的get请求类方法
+ (void)cacheGetWithURL: (NSString *)URLStr cookie: (NSString *)cookie success: (SUCCESS_BLOCK)successBlock failure: (FAILURE_BLOCK)failureBlock;
带缓存的post请求类方法
+ (void)cachePostWithURL: (NSString *)URLStr bodyStr: (NSString *)bodyStr cookie: (NSString *)cookie success: (SUCCESS_BLOCK)successBlock failure: (FAILURE_BLOCK)failureBlock;
