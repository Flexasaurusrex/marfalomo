# Marfa Lomography Gallery - Setup Guide

A clean, interactive photo gallery for your half-frame lomography from Marfa, Texas with user tagging functionality.

## 📦 What's Included

1. **marfa-gallery.html** - The main public gallery page
2. **marfa-admin.html** - Admin upload interface (requires login)
3. **marfa-gallery-schema.sql** - Database schema

## 🚀 Setup Instructions

### Step 1: Create Database Tables

1. Go to your Supabase project dashboard
2. Click on "SQL Editor" in the left sidebar
3. Copy the contents of `marfa-gallery-schema.sql`
4. Paste it into the SQL editor and click "Run"
5. You should see "Success. No rows returned" - this is normal!

### Step 2: Upload Your Photos

1. Open `marfa-admin.html` in your browser
2. Login with your Supabase credentials (same as your vonmesser.xyz admin)
3. Click or drag your Marfa photos into the upload zone
4. Click "Upload Photos" - they'll be automatically compressed and uploaded

### Step 3: Deploy the Gallery

Upload both HTML files to your web host (where vonmesser.xyz is hosted):
- `marfa-gallery.html` - Your public gallery
- `marfa-admin.html` - Keep this URL private for admin only

## ✨ Features

### For Viewers (Public)
- Clean portrait-oriented photo grid
- Click any photo to view full size
- Tag people in photos
- Add optional titles to photos
- Add social media links for tagged people
- Click tagged names to visit their profiles

### For You (Admin)
- Simple drag & drop upload
- Automatic image compression
- Progress tracking
- Easy batch uploads

## 🏷️ How Tagging Works

1. Anyone can click a photo to open the modal
2. They can add:
   - A photo title (optional, only if photo doesn't have one yet)
   - Person's name (required)
   - Social media link (optional - Twitter, Instagram, Farcaster, etc.)
3. Tags appear on the photo card and in the modal
4. Clickable tags link to social profiles if provided

## 🎨 Customization

### Change the Title/Subtitle
In `marfa-gallery.html`, find the hero section:
```html
<h1 class="hero-title">Marfa Memories</h1>
<p class="hero-subtitle">Half-frame lomography from West Texas</p>
<p class="hero-info">Kodak Ektar H35 • Artblocks Week • 2024</p>
```

### Change Colors
All colors are in the CSS at the top. Main colors:
- Background: `#fafafa`
- Dark text: `#1f2937`
- Mid gray: `#6b7280`
- Light gray: `#9ca3af`

### Change Grid Layout
In the `.gallery-grid` CSS:
```css
grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
```
Adjust `300px` to change column width.

## 📱 Mobile Friendly

Both pages are fully responsive and work great on phones and tablets.

## 🔒 Security Notes

- The gallery is public - anyone can view and tag
- Only authenticated users (you) can upload photos
- Keep the admin page URL private
- Tags are moderated by you (you can delete the tags table and recreate if needed)

## 🎯 Live Example Usage

1. Share the gallery URL with Artblocks Week attendees
2. People recognize themselves or friends in photos
3. They click, tag, and add context/stories
4. Creates a collaborative memory book of the event

## 💡 Tips

- Upload in batches of 20-30 photos at a time for best performance
- All photos will be automatically compressed to ~800px width
- Portrait orientation (3:4 aspect ratio) looks best
- Tags create engagement - encourage people to add memories!

## 🐛 Troubleshooting

**Photos not uploading?**
- Make sure you're logged in with admin credentials
- Check browser console for errors
- Verify database tables were created correctly

**Tags not showing?**
- Check browser console for errors
- Verify the photo_tags table exists in Supabase
- Make sure RLS policies were created correctly

**Need to reset tags?**
Run in Supabase SQL Editor:
```sql
DELETE FROM photo_tags;
```

## 🎨 Future Ideas

- Add photo dates
- Filter by tagged people
- Download original photos
- Like/heart photos
- Comments on photos
- Map view of photo locations

---

Created with ❤️ for documenting the magic of Marfa + lomography + Web3 culture
