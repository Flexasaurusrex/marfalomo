-- Marfa Photo Gallery Database Schema
-- Run this in your Supabase SQL Editor

-- Table for storing photos
CREATE TABLE marfa_photos (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    image_url TEXT NOT NULL,
    title TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table for storing user-contributed tags
CREATE TABLE photo_tags (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    photo_id UUID NOT NULL REFERENCES marfa_photos(id) ON DELETE CASCADE,
    person_name TEXT NOT NULL,
    social_link TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security (RLS)
ALTER TABLE marfa_photos ENABLE ROW LEVEL SECURITY;
ALTER TABLE photo_tags ENABLE ROW LEVEL SECURITY;

-- Allow public read access to photos
CREATE POLICY "Allow public read access to photos"
ON marfa_photos
FOR SELECT
TO public
USING (true);

-- Allow public read access to tags
CREATE POLICY "Allow public read access to tags"
ON photo_tags
FOR SELECT
TO public
USING (true);

-- Allow public insert access to tags (so anyone can tag)
CREATE POLICY "Allow public insert access to tags"
ON photo_tags
FOR INSERT
TO public
WITH CHECK (true);

-- Only you can insert photos (requires authentication)
-- This policy will work once you're logged in as admin
CREATE POLICY "Allow authenticated insert access to photos"
ON marfa_photos
FOR INSERT
TO authenticated
WITH CHECK (true);

-- Only you can update photos (requires authentication)
CREATE POLICY "Allow authenticated update access to photos"
ON marfa_photos
FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

-- Only you can delete photos (requires authentication)
CREATE POLICY "Allow authenticated delete access to photos"
ON marfa_photos
FOR DELETE
TO authenticated
USING (true);

-- Create indexes for better query performance
CREATE INDEX idx_photo_tags_photo_id ON photo_tags(photo_id);
CREATE INDEX idx_marfa_photos_created_at ON marfa_photos(created_at);
CREATE INDEX idx_photo_tags_created_at ON photo_tags(created_at);

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_marfa_photos_updated_at
    BEFORE UPDATE ON marfa_photos
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();
