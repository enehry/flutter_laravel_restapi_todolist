<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Todo;

class TodoController extends Controller
{
    //
    public function index(){
        return Todo::All();
    }

    public function store(){
        request()->validate([
            'title' => 'required',
            'title' => 'required',
        ]);
    
        return Todo::create([
            'title' => request('title'),
            'content' => request('content'),
            'is_done' => request('is_done', false),
        ]);
    }


    public function update(Todo $todo){
        request()->validate([
            'title' => 'required',
            'title' => 'required',
        ]);
    
        $success = $todo->update([
            'title' => request('title'),
            'content' => request('content'),
            'is_done' => request('is_done', false),
        ]);
    
    
        return [
            'success' => $success
        ];
    }

    public function destroy(Todo $todo){
        $success = $todo->delete();


        return [
            'success' => $success
        ];
    }
}
