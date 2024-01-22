import { Socket } from "socket.io";
import { db_pool } from "../config.mjs";
import { io } from '../index.mjs';



const modelPedido = {
    createPedido:async (pedido) => {
        try{
          //  console.log("-----PEDIDOO recibidoooo------")
           // console.log(pedido)
           // const io = await app_sol.get('io');
          console.log("-----PEDIDO INSERTADO-------")

            const pedidos = await db_pool.one('INSERT INTO ventas.pedido (cliente_id,monto_total,fecha,tipo,estado) VALUES ($1,$2,$3,$4,$5) RETURNING *',
            [pedido.cliente_id,pedido.monto_total,pedido.fecha,pedido.tipo,pedido.estado]);
            
           // const io = app_sol.get(io);
            //EMITIR UN EVENTO
           console.log("pedidos")
            io.emit('nuevoPedido',pedidos)

            return pedidos

        }
        catch(e){
            throw new Error(`Error query create:${e}`)
        }
    },
    getLastPedido: async (id) => {
        try {
            const lastPedido = await db_pool.one('SELECT id FROM ventas.pedido WHERE cliente_id=$1 ORDER BY id DESC LIMIT 1',[id]);
            return lastPedido;
        } catch (e) {
            throw new Error(`Error getting last pedido: ${e}`);
        }
    },

    getPedido: async ()=> {
        console.log("dentro de get....")
        
        try {
          const pedidos = await db_pool.any(`SELECT vp.id,vp.monto_total,vp.ruta_id,vp.fecha,vp.estado,vp.tipo,vc.nombre,vc.apellidos,vc.telefono,vc.ubicacion FROM ventas.pedido as vp
            INNER JOIN ventas.cliente as vc ON vp.cliente_id = vc.id 
            WHERE estado =  \'pendiente\'`);

          //  const pedidos = await db_pool.any('SELECT id,ruta_id,cliente_id,cliente_nr_id,monto_total,fecha,tipo,estado FROM ventas.pedido WHERE estado =  \'pendiente\'');
            //console.log("EMITIENDO PEDIDOS...GET,...")
            //io.emit('vista',"hola")
           // console.log(pedidos)
            return pedidos

        } catch (error) {
            throw new Error(`Error getting pedido: ${error}`)
        }
    },

    getPedidoConductor: async (rutaID,conductorID)=> {
        console.log("dentro de get Pedidos para Conductores....")
        
        try {
          const pedidos = await db_pool.any(`SELECT vp.id,vp.monto_total,vp.fecha,vp.estado,vp.tipo,vc.nombre,vc.apellidos,vc.telefono,vc.ubicacion,vc.direccion
          FROM ventas.ruta as vr INNER JOIN ventas.pedido as vp ON vr.id=vp.ruta_id
          INNER JOIN ventas.cliente as vc ON vp.cliente_id = vc.id 
          WHERE ruta_id=$1 and conductor_id=$2`,[rutaID,conductorID]);
          console.log(pedidos)
            return pedidos

        } catch (error) {
            throw new Error(`Error getting pedido: ${error}`)
        }
    },

    deletePedido: async (id) => {
        try {
            const result = await db_pool.result('DELETE FROM ventas.pedido WHERE ID = $1', [id]);
            return result.rowCount === 1; // Devuelve true si se eliminó un registro, false si no se encontró el registro
        } catch (error) {
            throw new Error(`Error en la eliminación del pedido: ${error.message}`);
        }
    },
    
    updateEstadoPedido: async (pedidoID,pedidoActualizado) => {

        try {
            const result = await db_pool.oneOrNone('UPDATE ventas.pedido SET estado = $1,foto=$2 WHERE id = $3 RETURNING *',
                [pedidoActualizado.estado,pedidoActualizado.foto,pedidoID]);

            if (!result) {
                throw new Error(`No se encontró un pedido con ID ${id}.`);
            }
            return { result }
        } catch (error) {
            throw new Error(`Error en la actualización del pedido: ${error.message}`);
        }
    },
    updateRutaPedido:async (id,ruta) => {
        try {
            const result  = await db_pool.oneOrNone('UPDATE ventas.pedido SET ruta_id = $1,estado = $2 WHERE id = $3 RETURNING *',
            [ruta.ruta_id,ruta.estado,id]);
            if (!result){
                return {"Message":"No se encontró un pedido con ese ID"}
            }
            return{result}
        } catch (error) {
            throw new Error(`Error en la actualización del pedido: ${error.message}`)
        }
    }
}

export default modelPedido;
