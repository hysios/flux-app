var _products = [{
        id: 0,
        name: 'iPhone 6',
        price: 4999,
        amount: 1000
    }, {
        id: 1,
        name: 'iPhone 6 Plus',
        price: 6999,
        amount: 888
    }
];

module.exports = {
    name: 'product',
    //At least one of the CRUD methods is required
    read: function(req, resource, params, config, callback) {
        setTimeout(function() {
            callback(null, JSON.parse(JSON.stringify(_products)));
            }, 10);
    }
};
