<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('grounds', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('ground_id')->unique();
            $table->string('category')->nullable();
            $table->unsignedInteger('total_bookings')->nullable();
            $table->unsignedInteger('price')->nullable();
            $table->longText('bio_data')->nullable();
            $table->string('status')->nullable();
            $table->foreign('ground_id')->references('id')->on('users')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('grounds');
    }
};
