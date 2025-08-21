<?php

namespace App\Http\Controllers\Admin\HomePage;

use App\Http\Controllers\Controller;
use App\Models\Intro;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use App\Http\Helpers\UploadFile;

class IntroController extends Controller
{
       public function index()
    {
        $intros = Intro::orderBy('created_at', 'desc')->get();
        return view('admin.home-page.intro.index', compact('intros'));
    }

    public function create()
    {
        return view('admin.home-page.intro.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'status' => 'required|in:0,1',
        ]);

        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = time() . '_' . uniqid() . '.' . $image->getClientOriginalExtension();
            $image->move(public_path('assets/img/intro-section'), $imageName);
        }

        Intro::create([
            'title' => $request->title,
            'image' => $imageName,
            'status' => $request->status,
        ]);

        Session::flash('success', __('Intro section created successfully!'));
        return view('admin.pages.home_page.intro.index');
    }

    public function edit($id)
    {
        $intro = Intro::findOrFail($id);
        return view('admin.home-page.intro.edit', compact('intro'));
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'status' => 'required|in:0,1',
        ]);

        $intro = Intro::findOrFail($id);

        if ($request->hasFile('image')) {
            if ($intro->image && file_exists(public_path('assets/img/intro-section/' . $intro->image))) {
                unlink(public_path('assets/img/intro-section/' . $intro->image));
            }
            
            $image = $request->file('image');
            $imageName = time() . '_' . uniqid() . '.' . $image->getClientOriginalExtension();
            $image->move(public_path('assets/img/intro-section'), $imageName);
            $intro->image = $imageName;
        }

        $intro->update([
            'title' => $request->title,
            'status' => $request->status,
        ]);

        Session::flash('success', __('Intro section updated successfully!'));
        return redirect()->route('admin.pages.home_page.intro.index');
    }

  
    public function destroy($id)
    {
        $intro = Intro::findOrFail($id);
        
        if ($intro->image && file_exists(public_path('assets/img/intro-section/' . $intro->image))) {
            unlink(public_path('assets/img/intro-section/' . $intro->image));
        }
        
        $intro->delete();
        
        Session::flash('success', __('Intro section deleted successfully!'));
        return redirect()->route('admin.pages.home_page.intro.index');
    }
} 