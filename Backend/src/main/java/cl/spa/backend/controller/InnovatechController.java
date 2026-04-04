package cl.spa.backend.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
public class InnovatechController {

    @GetMapping("/api/status")
    public Map<String, Object> status() {
        return Map.of(
                "proyecto", "Innovatech Chile",
                "arquitectura", "3 capas",
                "estado", "backend operativo",
                "flujo", "Front -> Back -> Data"
        );
    }

    @GetMapping("/api/componentes")
    public List<Map<String, Object>> componentes() {
        return List.of(
                Map.of(
                        "capa", "Frontend",
                        "tipo", "EC2 publica",
                        "funcion", "Servidor web",
                        "acceso", "Internet"
                ),
                Map.of(
                        "capa", "Backend",
                        "tipo", "EC2 privada",
                        "funcion", "Microservicio simple",
                        "acceso", "Solo desde Frontend"
                ),
                Map.of(
                        "capa", "Data",
                        "tipo", "EC2 privada",
                        "funcion", "Base de datos MySQL/PostgreSQL",
                        "acceso", "Solo desde Backend"
                )
        );
    }
}