import { db_pool } from "../config.mjs";

const modelLogin = {
    Login: async (credenciales) => {
        try {
            const tiposUsuarios = [
                { tipo: 'cliente', consulta: 'ventas.cliente' },
                { tipo: 'conductor', consulta: 'personal.conductor' },
                { tipo: 'empleado', consulta: 'personal.empleado' },
                { tipo: 'superadmin', consulta: 'personal.superadmin' },
                { tipo: 'administrador', consulta: 'personal.administrador' },
            ];

            for (const { tipo, consulta } of tiposUsuarios) {
                const resultado = await db_pool.oneOrNone(
                    `SELECT * FROM personal.usuario 
                    INNER JOIN ${consulta} ON personal.usuario.id = ${consulta}.usuario_id 
                    WHERE nickname=$1 AND contrasena=$2`,
                    [credenciales.nickname, credenciales.contrasena]
                );

                if (resultado) {
                    console.log(`${tipo}--->:`, resultado);
                    return  resultado ;
                }
            }

            // Si no se encuentra en ninguna consulta
            return null;
        } catch (e) {
            throw new Error(`Error en la consulta de inicio de sesión: ${e}`);
        }
    },
}

export default modelLogin;
