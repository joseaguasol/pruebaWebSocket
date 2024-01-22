import { db_pool } from "../config.mjs";

const modelProduct = {
    geAlltProduct:async () => {
        try{
            const product = await db_pool.any('select id,nombre,precio,descripcion,foto from ventas.producto');
            return product;
        }
        catch(e){
            throw new Error(`Error query create:${e}`);
        }
    },

    getONEProduct:async (productID) => {
        try{
            const product = await db_pool.any('SELECT id,nombre,descripcion FROM ventas.producto WHERE id=$1',[productID]);
            return product;
        }
        catch(e){
            throw new Error(`Error query create:${e}`);
        }
    },
}

export default modelProduct;
