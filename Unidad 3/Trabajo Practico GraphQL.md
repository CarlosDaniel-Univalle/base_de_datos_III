1. **Arquitectura y Estilo de Interfaz**:
   - **REST**: Utiliza una arquitectura basada en recursos, donde cada recurso se representa como una URL y se accede a través de métodos HTTP como GET, POST, PUT y DELETE.
   - **GraphQL**: Utiliza un único punto de entrada y permite a los clientes especificar qué datos desean utilizando un sistema de consultas.

2. **Overfetching y Underfetching**:
   - **REST**: Los clientes a menudo obtienen más datos de los necesarios (overfetching) o necesitan hacer múltiples solicitudes para obtener toda la información que necesitan (underfetching).
   - **GraphQL**: Los clientes pueden especificar exactamente qué datos desean en su consulta, evitando así el overfetching y underfetching.

3. **Versionamiento**:
   - **REST**: Suele requerir versiones explícitas en las URL para manejar cambios en la API, lo que puede llevar a la proliferación de rutas de versión.
   - **GraphQL**: Permite evolucionar el esquema sin necesidad de versiones explícitas, ya que los cambios pueden ser introducidos gradualmente sin romper las consultas existentes.

4. **Número de Solicitudes**:
   - **REST**: Los clientes a menudo deben realizar múltiples solicitudes a diferentes endpoints para obtener datos relacionados.
   - **GraphQL**: Los clientes pueden obtener todos los datos relacionados en una sola solicitud.

5. **Sobrecarga de Datos en la Red**:
   - **REST**: Las respuestas de REST a menudo contienen información innecesaria, lo que puede aumentar la sobrecarga de datos en la red.
   - **GraphQL**: Las respuestas se adaptan a las necesidades del cliente, lo que reduce la sobrecarga de datos.

6. **Documentación Automatizada**:
   - **REST**: La documentación suele ser más desafiante y suele requerir herramientas de documentación separadas.
   - **GraphQL**: La estructura auto-documentada de GraphQL facilita la generación automática de documentación.

7. **Seguridad de Datos**:
   - **REST**: La seguridad se gestiona a nivel de endpoint, lo que puede ser más difícil de controlar.
   - **GraphQL**: Permite una mayor granularidad en el control de acceso a los campos individuales, lo que facilita la implementación de políticas de seguridad más precisas.

8. **Optimización de Solicitudes**:
   - **REST**: Los servidores REST pueden estar sujetos a problemas de sub o sobre-solicitud de datos, lo que dificulta la optimización.
   - **GraphQL**: Los servidores GraphQL pueden optimizar consultas y recuperar solo los datos necesarios.

9. **Caché**:
   - **REST**: Los mecanismos de caché en REST son más sencillos y se basan en las cabeceras HTTP como "ETag" y "Last-Modified".
   - **GraphQL**: GraphQL no especifica un mecanismo de caché en sí mismo, pero es posible implementar estrategias de caché personalizadas.

10. **Adopción**:
    - **REST**: Es ampliamente utilizado y bien establecido en la industria.
    - **GraphQL**: Aunque está ganando tracción rápidamente, GraphQL todavía no es tan ampliamente adoptado como REST.