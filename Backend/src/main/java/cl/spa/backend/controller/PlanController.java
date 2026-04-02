package cl.spa.backend.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/planes")
public class PlanController {

    @GetMapping
    public List<Map<String, Object>> listarPlanes() {
        return List.of(
                Map.of("id", 1, "nombre", "Plan Básico"),
                Map.of("id", 2, "nombre", "Plan Premium"),
                Map.of("id", 3, "nombre", "Plan Corporativo")
        );
    }
}