import BaseStore from 'dispatchr/utils/BaseStore';

class ProductStore extends BaseStore {
  constructor (dispatcher) {
    this.dispatcher = dispatcher;
    this.products = {};
  }

  get(id) {
    return this.products[id];
  }

  getAll () {
    var results = [];
    for (var key in this.products) {
      if (this.products.hasOwnProperty(key)) {
        results.push(this.products[key]);
      }
    }

    return results;
  }

  receviceProducts (products = []) {
    var self = this;
    products.forEach(function(product) {
      self.products[product.id] = product;
    })
  }

  dehydrate () {
    return {
      products: this.products
    }
  }

  rehydrate (state) {
    this.products = state.products;
  }
}

ProductStore.storeName = 'ProductStore';
ProductStore.handlers = {
  RECEVICE_PRODUCTS: 'receviceProducts'
};

module.exports = ProductStore;
