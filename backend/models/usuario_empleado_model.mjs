import { db_pool } from "../config.mjs";

const modelUserEmpleado = {
    createUserEmpleado: async (empleado) => {
        try {
            const usuario = await db_pool.one('INSERT INTO personal.usuario (rol_id,nickname, contrasena, email) VALUES ($1,$2,$3,$4) RETURNING *',
                [empleado.rol_id, empleado.nickname, empleado.contrasena, empleado.email]);

            const empleados = await db_pool.one('INSERT INTO personal.empleado (usuario_id, nombres, apellidos, dni, fecha_nacimiento, codigo_empleado) VALUES ($1,$2,$3,$4,$5,$6) RETURNING *',
                [usuario.id, empleados.usuario_id, empleados.nombres, empleados.apellidos, empleados.dni, empleados.fecha_nacimiento, empleados.codigo_empleado]);

            return empleados

        }
        catch (e) {
            throw new Error(`Error query create:${e}`)
        }
    },
    updateUserEmpleado: async (id, empleado) => {

        try {
            const usuario = await db_pool.oneOrNone('UPDATE personal.usuario SET rol_id = $1, nickname = $2, contrasena = $3, email = $4 WHERE id = $5 RETURNING *',
                [empleado.rol_id, empleado.nickname, empleado.contrasena, empleado.email, id]);

            if (!usuario) {
                throw new Error(`No se encontró un usuario con ID ${id}.`);
            }

            const empleados = await db_pool.one('UPDATE personal.empleado SET nombres=$1, apellidos=$2, dni=$3, fecha_nacimiento=$4, codigo_empleado=$5 WHERE usuario_id = $6 RETURNING *',
                [empleados.nombres, empleados.apellidos, empleados.dni, empleados.fecha_nacimiento, empleados.codigo_empleado, id]);
            console.log("dentro de model 2do update", id)
            return { usuario, empleados }
        } catch (error) {
            throw new Error(`Error en la actualización del administrador: ${error.message}`);
        }
    },
    getUsersEmpleado: async () => {
        try {
            const userEmpleado = await db_pool.any('select * from personal.usuario inner join personal.empleado on personal.usuario.id = personal.empleado.usuario_id;')
            return userEmpleado
        } catch (e) {
            throw new Error(`Error query clients: ${err}`);
        }
    },
    deleteUserEmpleado: async (id) => {
        try {
            const result = await db_pool.result('DELETE FROM personal.usuario WHERE ID = $1', [id]);
            return result.rowCount === 1; // Devuelve true si se eliminó un registro, false si no se encontró el registro
        } catch (error) {
            throw new Error(`Error en la eliminación del cliente: ${error.message}`);
        }
    },
}
export default modelUserEmpleado;