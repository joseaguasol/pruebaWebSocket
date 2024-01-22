import modelLogin from "../models/login_models.mjs";

export const getUsers = async (req,res) => {
    try {
        const credenciales = req.body
        const getuser = await modelLogin.Login(credenciales)
        res.json(getuser);
    } catch (error) {
        res.status(500).json({error:error.message})
    }
}