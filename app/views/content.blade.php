@extends('index')

@section('content')

    <!-- Image Background Page Header -->
    <!-- Note: The background image is set within the business-casual.css file. -->
    <header class="business-header">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="tagline">Viaja con tu Mascota!</h1>
                </div>
            </div>
        </div>
    </header>

    <!-- Page Content -->
    <div class="container">

        <hr>

        <div class="row">
            <div class="col-sm-8">
                <h2>¿Quiénes Somos? ¿Qué hacemos? ¿Por qué?</h2>
                <p>Hola Somos Chava y Lesslie, hace 4 años nos mudamos al DF desde Tijuana y nos hemos dado a la tarea de conocer el centro del país. Hace 3 años nos encontramos con Lucy, una San Bernardo que nos ha sido nuestra fiel compañera de viajes.</p>
                <p>A lo largo de estos años nos hemos encontrado con mucha gente que nos comenta que ellos quieren viajar con sus mascotas, pero no lo hacen porque no saben donde alojarse o que tanto pueden conocer con sus amigos peludos. Es por eso que iniciamos este proyecto, para compartir información sobre todos los detalles de viajar con tu mascota.</p>
                <p>
                    <a class="btn btn-default btn-lg" href="#">Ver viajes &raquo;</a>
                </p>
            </div>
            <div class="col-sm-4">
                <h2>Contacto</h2>
                <img src="/images/socialbuttons.png" />
                <address>
                    <strong>Viaja con tu mascota</strong>
                </address>
                <address>
                    <abbr title="Email">E:</abbr> <a href="mailto:#">contacto@viajacontumascota.mx</a>
                </address>
            </div>
        </div>
        <!-- /.row -->

        <hr>

        <div class="row">
            <div class="col-sm-4">
                <img class="img-circle img-responsive img-center" src="/images/chiapas-small.jpg" alt="">
                <h2>Chiapas</h2>
                <p>Todos los detalles de nuestro recorrido por Chiapas con Lucy, estancias, comida, paseos, precios, etc.</p>
                <p>Visitamos, Tuxtla Gutierrez, San Cristobal De Las Casas, Chiapa de Corzo, Lagunas de Montebello, Cascada del Velo de Novia, Misol-Ha, Bonampak, Agua Azul, Palenque y más.</p>
            </div>
            <div class="col-sm-4">
                <img class="img-circle img-responsive img-center" src="/images/sanluis-small.jpg" alt="">
                <h2>San Luis Potosí</h2>
                <p>En esta visita a San Luis Potosí, Lucy visitó la capital, Real de Catorce, Estación Catorce, Tamasopo y Puente de Dios.</p>
                <p>En el viaje anterior conoció Xilitla, Aquismón (Tamul y Sótano de las Golondrinas), Ciudad Valles y Tamasopo.</p>
            </div>
            <div class="col-sm-4">
                <img class="img-circle img-responsive img-center" src="/images/veracruz-small.jpg" alt="">
                <h2>Veracruz</h2>
                <p>En Veracruz Lucy pasó un fin de semana relajante en la playa de Costa Esmeralda, donde además conoció a una amiga.</p>
            </div>
        </div>
        <!-- /.row -->

        <hr>

        <!-- Footer -->
        <footer>
            <div class="row">
                <div class="col-lg-12">
                    <p>Copyright &copy; Your Website 2014</p>
                </div>
            </div>
            <!-- /.row -->
        </footer>

    </div>
    <!-- /.container -->

@stop
