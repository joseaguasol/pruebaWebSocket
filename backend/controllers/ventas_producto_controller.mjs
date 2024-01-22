import modelProduct from "../models/ventas_producto_model.mjs";

export const getAllProducts = async (req,res) => {
    try {
        const allproduct= await modelProduct.geAlltProduct();
        res.json(allproduct);
    } catch (error) {
        res.status(500).json({error:error.message});

    }
}

export const getONEProducts = async (req,res) => {
    try{
        const { productID } = req.params;
        const id = parseInt(productID, 10);
        const getUNproducto = await modelProduct.getONEProduct(id);
        res.json(getUNproducto);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

