import { db_pool } from "../config.mjs";

const modelUserConductor = {
    createUserConductor:async (conductor) => {
        try{
            const usuario = await db_pool.one('INSERT INTO personal.usuario (rol_id,nickname, contrasena, email) VALUES ($1,$2,$3,$4) RETURNING *',
            [conductor.rol_id,conductor.nickname,conductor.contrasena,conductor.email]);
            
            const conductores = await db_pool.one('INSERT INTO personal.conductor (usuario_id, nombres, apellidos, licencia, dni, fecha_nacimiento) VALUES ($1,$2,$3,$4,$5,$6) RETURNING *',
            [usuario.id, conductor.nombres, conductor.apellidos, conductor.licencia, conductor.dni, conductor.fecha_nacimiento]);

            return conductores

        }
        catch(e){
            throw new Error(`Error query create:${e}`)
        }
    },
    updateUserConductor: async (id,conductor) => {
      
        try {
            const usuario = await db_pool.oneOrNone('UPDATE personal.usuario SET rol_id = $1, nickname = $2, contrasena = $3, email = $4 WHERE id = $5 RETURNING *',
                [conductor.rol_id,conductor.nickname, conductor.contrasena, conductor.email,id]);

            if (!usuario) {
                throw new Error(`No se encontró un usuario con ID ${id}.`);
            }

            const conductor = await db_pool.one('UPDATE personal.conductor SET nombres=$1, apellidos=$2, licencia=$3, dni=$4, fecha_nacimiento=$5 WHERE usuario_id = $6 RETURNING *',
                [conductor.nombres,conductor.apellidos,conductor.licencia,conductor.dni,conductor.fecha_nacimiento,id]);
            console.log("dentro de model 2do update",id)
            return {usuario,administrador}
        } catch (error) {
            throw new Error(`Error en la actualización del conductor: ${error.message}`);
        }
    },
    getUsersConductor:async () => {
        try{
            const userConductores = await db_pool.any('select * from personal.usuario inner join personal.conductor on personal.usuario.id = personal.conductor.usuario_id')
            return userConductores
        }catch(e){
            throw new Error(`Error query clients: ${err}`);
        }
    },
    deleteUserConductor: async (id) => {
        try {
            const result = await db_pool.result('DELETE FROM personal.usuario WHERE ID = $1', [id]);
            return result.rowCount === 1; // Devuelve true si se eliminó un registro, false si no se encontró el registro
        } catch (error) {
            throw new Error(`Error en la eliminación del cliente: ${error.message}`);
        }
    },
}
export default modelUserConductor;