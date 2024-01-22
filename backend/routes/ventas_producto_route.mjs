import { getAllProducts,getONEProducts } from '../controllers/ventas_producto_controller.mjs';
import express from 'express';

const routerVentasProduct = express.Router();

routerVentasProduct.get('/products',getAllProducts),
routerVentasProduct.get('/products/:productID',getONEProducts)






export default routerVentasProduct;
