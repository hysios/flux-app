module.exports = function(context, payload, callback){
  context.fetcher.read('product', {}, {}, function(err, products) {
	context.getStore("ProductStore");

    context.dispatch('RECEVICE_PRODUCTS', products);
    callback()
  });
}
