<?php

namespace App\Http\Controllers\Admin\AboutUs;

use App\Http\Controllers\Controller;
use App\Http\Helpers\UploadFile;
use App\Models\HomePage\Feature;
use App\Models\Language;
use App\Rules\ImageMimeTypeRule;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use Mews\Purifier\Facades\Purifier;

class FeaturesController extends Controller
{
    public function storeFeatures(Request $request)
    {
        $rules = [
            'title' => 'required|max:255',
            'subtitle' => 'required|max:255',
            'image' => 'required|' . new ImageMimeTypeRule(),
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()->toArray()
            ], 400);
        }

        $language = Language::where('code', $request->language)->firstOrFail();

        $image = $request->file('image');
        $imageName = UploadFile::store('./assets/img/feature/', $image);

        Feature::create([
            'language_id' => $language->id,
            'title' => $request->title,
            'subtitle' => $request->subtitle,
            'image' => $imageName,
        ]);

        Session::flash('success', __('Feature added successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function updateFeatures(Request $request)
    {
        $rules = [
            'title' => 'required|max:255',
            'subtitle' => 'required|max:255',
            'image' => new ImageMimeTypeRule(),
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()->toArray()
            ], 400);
        }

        $feature = Feature::findOrFail($request->id);

        $image = $request->file('image');
        if ($image) {
            $imageName = UploadFile::store('./assets/img/feature/', $image);
            $feature->image = $imageName;
        }

        $feature->title = $request->title;
        $feature->subtitle = $request->subtitle;
        $feature->save();

        Session::flash('success', __('Feature updated successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function destroy($id)
    {
        $feature = Feature::findOrFail($id);
        $feature->delete();

        Session::flash('success', __('Feature deleted successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request->ids;
        Feature::whereIn('id', $ids)->delete();

        Session::flash('success', __('Features deleted successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }
}
