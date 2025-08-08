<x-layout>
<x-slot:heading>
    Home page
</x-slot:heading>

<main>
    @if ($user)
        <h1>Hello {{ $user->first_name }}</h1>
    @endif
</main>
</x-layout>