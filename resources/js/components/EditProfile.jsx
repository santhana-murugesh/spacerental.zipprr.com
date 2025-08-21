import React, { useEffect, useMemo, useState } from 'react'
import { DashboardLayout } from './DashboardLayout'
import { useAuth } from './AuthContext'

export const EditProfile = () => {
	const { user, authLoading, token, setUser } = useAuth()
	const [form, setForm] = useState({
		name: '',
		username: '',
		email: '',
		phone: '',
		country: '',
		city: '',
		state: '',
		zip_code: '',
		address: '',
	})
	const [imageFile, setImageFile] = useState(null)
	const [imagePreview, setImagePreview] = useState(null)
	const [submitting, setSubmitting] = useState(false)
	const [notice, setNotice] = useState(null)
	const [error, setError] = useState(null)

	const API_BASE_URL =
		window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
			? import.meta.env.VITE_API_BASE_URL_LOCAL
			: import.meta.env.VITE_API_BASE_URL

	useEffect(() => {
		if (user) {
			setForm((prev) => ({
				...prev,
				name: user.name || '',
				username: user.username || '',
				email: user.email || '',
				phone: user.phone || '',
				country: user.country || '',
				city: user.city || '',
				state: user.state || '',
				zip_code: user.zip_code || '',
				address: user.address || '',
			}))
			if (user.image) {
				setImagePreview(`${window.location.origin}/assets/img/users/${user.image}`)
			}
		}
	}, [user])

	const handleChange = (e) => {
		const { name, value } = e.target
		setForm((prev) => ({ ...prev, [name]: value }))
	}

	const handleImage = (e) => {
		const file = e.target.files?.[0] || null
		setImageFile(file)
		if (file) {
			const reader = new FileReader()
			reader.onload = () => setImagePreview(reader.result)
			reader.readAsDataURL(file)
		} else {
			setImagePreview(null)
		}
	}

	const submitViaApi = async () => {
		const fd = new FormData()
		Object.entries(form).forEach(([k, v]) => fd.append(k, v ?? ''))
		if (imageFile) fd.append('image', imageFile)
		const res = await fetch(`${API_BASE_URL}/api/user/update-profile`, {
			method: 'POST',
			headers: { Authorization: `Bearer ${token}` },
			body: fd,
		})
		if (res.status === 422) {
			const data = await res.json()
			const first = data?.errors ? Object.values(data.errors)[0]?.[0] : null
			throw new Error(first || 'Validation failed')
		}
		if (!res.ok) throw new Error('Failed to update profile')
		const data = await res.json()
		if (data?.user) setUser(data.user)
	}

	const submitViaWeb = async () => {
		const csrfRes = await fetch('/csrf-token', { credentials: 'same-origin' })
		const csrf = await csrfRes.json()
		const fd = new FormData()
		Object.entries(form).forEach(([k, v]) => fd.append(k, v ?? ''))
		if (imageFile) fd.append('image', imageFile)
		const res = await fetch('/user/update-profile', {
			method: 'POST',
			credentials: 'same-origin',
			headers: { 'X-CSRF-TOKEN': csrf.token, Accept: 'application/json', 'X-Requested-With': 'XMLHttpRequest' },
			body: fd,
		})
		if (res.status === 422) {
			const data = await res.json()
			const first = data?.errors ? Object.values(data.errors)[0]?.[0] : null
			throw new Error(first || 'Validation failed')
		}
		if (!(res.ok || res.status === 302)) throw new Error('Failed to update profile')
	}

	const handleSubmit = async (e) => {
		e.preventDefault()
		setSubmitting(true)
		setError(null)
		setNotice(null)
		try {
			if (token) {
				await submitViaApi()
			} else {
				await submitViaWeb()
			}
			setNotice('Your profile has been updated successfully.')
		} catch (err) {
			setError(err.message || 'Failed to update profile')
		} finally {
			setSubmitting(false)
		}
	}

	if (authLoading) {
		return <div className="flex justify-center items-center min-h-screen">Loading...</div>
	}

	if (!user) {
		return <div className="flex justify-center items-center min-h-screen">Please log in to edit your profile.</div>
	}

	return (
		<DashboardLayout title="Edit Profile">
			<div className="bg-white rounded-lg shadow-sm p-6">
				{notice && (
					<div className="mb-4 rounded-md bg-green-50 border border-green-200 p-3 text-green-800 text-sm">
						{notice}
					</div>
				)}
				{error && (
					<div className="mb-4 rounded-md bg-red-50 border border-red-200 p-3 text-red-800 text-sm">
						{error}
					</div>
				)}

				<form onSubmit={handleSubmit} className="space-y-6">
					<div className="flex items-center space-x-4">
						<div className="w-20 h-20 rounded-full overflow-hidden bg-gray-100 border border-gray-200">
							{imagePreview ? (
								<img src={imagePreview} alt="avatar" className="w-20 h-20 object-cover" />
							) : (
								<div className="w-full h-full flex items-center justify-center text-gray-400 text-xs">
									80x80
								</div>
							)}
						</div>
						<div>
							<label className="block text-sm font-medium text-gray-700">Image (80x80)</label>
							<input type="file" accept="image/*" onChange={handleImage} className="mt-1 block text-sm" />
							<p className="mt-1 text-xs text-gray-500">PNG/JPG. Required 80x80.</p>
						</div>
					</div>

					<div className="grid grid-cols-1 md:grid-cols-2 gap-4">
						<div>
							<label className="block text-sm font-medium text-gray-700">Name *</label>
							<input name="name" value={form.name} onChange={handleChange} required className="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
						</div>
						<div>
							<label className="block text-sm font-medium text-gray-700">Username *</label>
							<input name="username" value={form.username} onChange={handleChange} required className="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
						</div>
						<div>
							<label className="block text-sm font-medium text-gray-700">Email *</label>
							<input type="email" name="email" value={form.email} onChange={handleChange} required className="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
						</div>
						<div>
							<label className="block text-sm font-medium text-gray-700">Phone</label>
							<input name="phone" value={form.phone} onChange={handleChange} className="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
						</div>
						<div>
							<label className="block text-sm font-medium text-gray-700">Country</label>
							<input name="country" value={form.country} onChange={handleChange} className="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
						</div>
						<div>
							<label className="block text-sm font-medium text-gray-700">City</label>
							<input name="city" value={form.city} onChange={handleChange} className="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
						</div>
						<div>
							<label className="block text-sm font-medium text-gray-700">State</label>
							<input name="state" value={form.state} onChange={handleChange} className="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
						</div>
						<div>
							<label className="block text-sm font-medium text-gray-700">Zip Code</label>
							<input name="zip_code" value={form.zip_code} onChange={handleChange} className="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
						</div>
						<div className="md:col-span-2">
							<label className="block text-sm font-medium text-gray-700">Address</label>
							<input name="address" value={form.address} onChange={handleChange} className="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
						</div>
					</div>

					<div className="flex justify-end">
						<button type="submit" disabled={submitting} className="px-4 py-2 rounded-md text-white bg-blue-600 hover:bg-blue-700 disabled:opacity-50">
							{submitting ? 'Saving...' : 'Save Changes'}
						</button>
					</div>
				</form>
			</div>
		</DashboardLayout>
	)
}
